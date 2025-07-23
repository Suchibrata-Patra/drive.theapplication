from pushbullet import Pushbullet

API_KEY = "o.aifU7dLqmilwmPs8gb4KORJuzAju0s2J"

def send_push_notification(*args):
    """
    Send a Pushbullet notification.
    If one argument is passed, it's used as the body with a default title.
    If two arguments are passed, they're treated as title and body.
    """
    try:
        pb = Pushbullet(API_KEY)

        if len(args) == 1:
            title = "Script Notification"
            body = args[0]
        elif len(args) == 2:
            title, body = args
        else:
            raise ValueError("send_push_notification takes either 1 or 2 arguments.")

        result = pb.push_note(title, body)
        print("Notification sent successfully!")

    except Exception as e:
        error_body = f"Notification failed with error: {str(e)}"
        try:
            pb = Pushbullet(API_KEY)
            pb.push_note("Script Error", error_body)
        except:
            print("Failed to send error notification as well.")
        raise
    