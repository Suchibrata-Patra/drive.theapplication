import tkinter as tk
from tkinter import filedialog, messagebox, scrolledtext, ttk
import os
import SimpleITK as sitk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import numpy as np

class CoregGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Double Coregistration: Flair & MD")
        self.root.geometry("900x700")

        self.base_path = tk.StringVar()

        self.notebook = ttk.Notebook(root)
        self.main_frame = tk.Frame(self.notebook)
        self.viewer_frame = tk.Frame(self.notebook)
        self.compare_frame = tk.Frame(self.notebook)

        self.notebook.add(self.main_frame, text="Registration")
        self.notebook.add(self.viewer_frame, text="Slide Viewer")
        self.notebook.add(self.compare_frame, text="Compare Viewer")
        self.notebook.pack(fill=tk.BOTH, expand=True)

        # === MAIN TAB ===
        tk.Label(self.main_frame, text="Select Patient Folder (e.g., pt_68)").pack(pady=10)
        path_frame = tk.Frame(self.main_frame)
        path_frame.pack()
        tk.Entry(path_frame, textvariable=self.base_path, width=80).pack(side=tk.LEFT, padx=5)
        tk.Button(path_frame, text="Browse", command=self.browse_folder).pack(side=tk.LEFT)

        tk.Button(self.main_frame, text="Start Registration", command=self.start_registration,
                  bg="#4CAF50", fg="white", font=("Arial", 12, "bold")).pack(pady=10)
        tk.Button(self.main_frame, text="Show Slides", command=self.show_slide_tab,
                  bg="#2196F3", fg="white", font=("Arial", 12, "bold")).pack(pady=5)
        tk.Button(self.main_frame, text="Compare Slices (Before vs After)", command=self.compare_before_after,
                  bg="#FF5722", fg="white", font=("Arial", 12, "bold")).pack(pady=5)

        self.log_box = scrolledtext.ScrolledText(self.main_frame, height=15, width=90, state='disabled')
        self.log_box.pack()

        # === SLIDE VIEWER TAB ===
        self.slice_slider = tk.Scale(self.viewer_frame, from_=0, to=100, orient=tk.HORIZONTAL, command=self.update_slice)
        self.slice_slider.pack(fill=tk.X, padx=20, pady=5)

        self.fig, (self.ax1, self.ax2) = plt.subplots(1, 2)
        self.canvas = FigureCanvasTkAgg(self.fig, master=self.viewer_frame)
        self.canvas.get_tk_widget().pack(fill=tk.BOTH, expand=True)

        self.md_image = None
        self.rcbv_image = None

        # === COMPARE VIEWER TAB ===
        self.compare_slider = tk.Scale(self.compare_frame, from_=0, to=100, orient=tk.HORIZONTAL, command=self.update_compare_slice)
        self.compare_slider.pack(fill=tk.X, padx=20, pady=5)

        self.compare_fig, (self.ax_cmp1, self.ax_cmp2, self.ax_cmp3) = plt.subplots(1, 3)
        self.compare_canvas = FigureCanvasTkAgg(self.compare_fig, master=self.compare_frame)
        self.compare_canvas.get_tk_widget().pack(fill=tk.BOTH, expand=True)

        self.moving_array = None
        self.fixed_array = None
        self.registered_array = None

    def browse_folder(self):
        selected = filedialog.askdirectory()
        if selected:
            self.base_path.set(selected)

    def log(self, msg): # Log file Storage 
        self.log_box.configure(state='normal')
        self.log_box.insert(tk.END, msg + "\n")
        self.log_box.see(tk.END)
        self.log_box.configure(state='disabled')

    def register_images(self, fixed_path, moving_path, output_path, use_wall_clock=False): ## egistering the image
        self.log(f"\U0001F50D Fixed: {fixed_path}")
        self.log(f"\U0001F69A Moving: {moving_path}")
        fixed_image = sitk.ReadImage(fixed_path, sitk.sitkFloat32)
        moving_image = sitk.ReadImage(moving_path, sitk.sitkFloat32)

        if fixed_image.GetPixelID() != moving_image.GetPixelID():
            moving_image = sitk.Cast(moving_image, fixed_image.GetPixelID())

        registration_method = sitk.ImageRegistrationMethod()
        initial_transform = sitk.CenteredTransformInitializer(
            fixed_image,
            moving_image,
            sitk.Euler3DTransform(),
            sitk.CenteredTransformInitializerFilter.GEOMETRY
        )

        registration_method.SetInitialTransform(initial_transform, inPlace=False)
        registration_method.SetMetricAsMattesMutualInformation(numberOfHistogramBins=50)

        if use_wall_clock:
            registration_method.SetMetricSamplingPercentage(0.1, sitk.sitkWallClock)
        else:
            registration_method.SetMetricSamplingPercentage(0.1)
        registration_method.SetMetricSamplingStrategy(registration_method.RANDOM)
        registration_method.SetOptimizerAsGradientDescentLineSearch(
            learningRate=1.0,
            numberOfIterations=100,
            convergenceMinimumValue=1e-6,
            convergenceWindowSize=10
        )
        registration_method.SetOptimizerScalesFromPhysicalShift()
        registration_method.SetInterpolator(sitk.sitkLinear)

        self.log("\U0001F527 Executing registration...")
        final_transform = registration_method.Execute(fixed_image, moving_image)

        resampled_image = sitk.Resample(
            moving_image,
            fixed_image,
            final_transform,
            sitk.sitkLinear,
            0.0,
            moving_image.GetPixelID()
        )

        sitk.WriteImage(resampled_image, output_path)
        self.log(f"Saved: {output_path}\n")

    def start_registration(self): # Starrting the egistratino Process
        base_path = self.base_path.get().strip()
        if not base_path:
            messagebox.showerror("Error", "Please select a patient folder.")
            return

        try:
            patient_id = os.path.basename(base_path.rstrip('/'))
            fixed_flair = os.path.join(base_path, "DSC/t0119/PERFUSION.nii.gz")
            moving_flair = os.path.join(base_path, "DTI/t30/AXIAL_DTI_BRAIN.nii.gz")
            flair_output = os.path.join(base_path, f"DTI_Coreg_{patient_id}.nii")

            self.log("\U0001F680 Starting FLAIR coregistration...")
            self.register_images(fixed_flair, moving_flair, flair_output, use_wall_clock=True)

            fixed_md = fixed_flair
            moving_md = os.path.join(base_path, "DTI_Maps/MD.nii.gz")
            md_output = os.path.join(base_path, "MD_registered_straight.nii")

            self.log("\U0001F680 Starting MD coregistration...")
            self.register_images(fixed_md, moving_md, md_output)

            messagebox.showinfo("Success", f"Both coregistrations completed.\n\n→ {flair_output}\n→ {md_output}")

        except Exception as e:
            self.log(f"❌ Error: {str(e)}")
            messagebox.showerror("Exception", str(e))

    def show_slide_tab(self):
        base_path = self.base_path.get().strip()
        md_path = os.path.join(base_path, "MD_registered_straight.nii")
        rcbv_path = os.path.join(base_path, "DSC/DSC_4d/rcbv_rotated.nii.gz")

        try:
            self.md_image = sitk.GetArrayFromImage(sitk.ReadImage(md_path))
            self.rcbv_image = sitk.GetArrayFromImage(sitk.ReadImage(rcbv_path))

            min_slices = min(self.md_image.shape[0], self.rcbv_image.shape[0])
            self.slice_slider.config(to=min_slices - 1)
            self.update_slice(0)
            self.notebook.select(self.viewer_frame)

        except Exception as e:
            self.log(f"Slide View Error: {str(e)}")
            messagebox.showerror("Slide Viewer Error", str(e))

    def update_slice(self, val):
        idx = int(val)
        if self.md_image is None or self.rcbv_image is None:
            return

        self.ax1.clear()
        self.ax2.clear()
        self.ax1.imshow(self.md_image[idx, :, :], cmap='gray')
        self.ax1.set_title(f"MD Slice {idx}")
        self.ax2.imshow(self.rcbv_image[idx, :, :], cmap='hot')
        self.ax2.set_title(f"RCBV Slice {idx}")
        self.canvas.draw()

    def compare_before_after(self):
        base_path = self.base_path.get().strip()
        try:
            moving_path = os.path.join(base_path, "DTI_Maps/MD.nii.gz")
            fixed_path = os.path.join(base_path, "DSC/t0119/PERFUSION.nii.gz")
            registered_path = os.path.join(base_path, "MD_registered_straight.nii")

            moving_image = sitk.ReadImage(moving_path)
            fixed_image = sitk.ReadImage(fixed_path)
            registered_image = sitk.ReadImage(registered_path)

            self.moving_array = sitk.GetArrayFromImage(moving_image)
            self.fixed_array = sitk.GetArrayFromImage(fixed_image)
            self.registered_array = sitk.GetArrayFromImage(registered_image)

            min_slices = min(
                self.moving_array.shape[0],
                self.fixed_array.shape[0],
                self.registered_array.shape[0]
            )
            self.compare_slider.config(to=min_slices - 1)
            self.update_compare_slice(0)
            self.notebook.select(self.compare_frame)

        except Exception as e:
            self.log(f"Slice Comparison Error: {str(e)}")
            messagebox.showerror("Comparison Viewer Error", str(e))

    def update_compare_slice(self, val):
        idx = int(val)
        if self.moving_array is None or self.fixed_array is None or self.registered_array is None:
            return

        self.ax_cmp1.clear()
        self.ax_cmp2.clear()
        self.ax_cmp3.clear()

        self.ax_cmp1.imshow(self.moving_array[idx, :, :], cmap='gray')
        self.ax_cmp1.set_title(f'Moving Slice {idx}')
        self.ax_cmp1.axis('off')

        self.ax_cmp2.imshow(self.fixed_array[idx, :, :], cmap='jet')
        self.ax_cmp2.set_title(f'Fixed Slice {idx}')
        self.ax_cmp2.axis('off')

        self.ax_cmp3.imshow(self.registered_array[idx, :, :], cmap='jet')
        self.ax_cmp3.set_title(f'Registered Slice {idx}')
        self.ax_cmp3.axis('off')

        self.compare_canvas.draw()

if __name__ == "__main__":
    root = tk.Tk()
    app = CoregGUI(root)
    root.mainloop()
