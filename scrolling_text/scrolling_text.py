import time
import os

def scroll_text(text, width=40):
    padded_text = ' ' * width + text + ' ' * width
    length = len(padded_text)

    for i in range(length - width):
        os.system('cls' if os.name == 'nt' else 'clear')
        print(padded_text[i:i + width])
        time.sleep(0.2)

if __name__ == "__main__":
    text = "This is animated text on the screen!"
    scroll_text(text)