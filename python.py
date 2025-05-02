import time
import pyautogui

def type_with_pause(text, pause=0.5, repeat=1):
    for _ in range(repeat):
        for char in text:
            pyautogui.typewrite(char)
            time.sleep(pause)
        pyautogui.press('enter')
        time.sleep(pause)

if __name__ == "__main__":
    type_with_pause("hello", pause=0.5, repeat=200000000000)