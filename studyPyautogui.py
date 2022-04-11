from re import X
from PIL.ImageOps import grayscale
import pyautogui

# 设置保护措施，光标移到左上角就会中断程序
pyautogui.FAILSAFE = True
# 操作延时，单位：秒
pyautogui.PAUSE = 0.75

##获取屏幕分辨率
width, height = pyautogui.size()
##移动鼠标(x, y, 持续时间（秒）)
# pyautogui.moveTo(100, 100, 0.2)
# 移动相对位置
# pyautogui.move(10, 10, 0.2)
##拖动(x, y, 持续时间, left|middle|right)
# pyautogui.dragTo(100, 100, 0.2, button='left')
# pyautogui.drag(10, 10, 0.2, button='right')
##点击左键
# pyautogui.click()
# 0.2秒的间隔，点击两次右键
# pyautogui.click(button='right', clicks=2, interval=0.2)
# 双击
# pyautogui.doubleClick()
# 三击
# pyautogui.tripleClick()
# 右击
# pyautogui.rightClick()
# 鼠标移动到100，100 然后再单击左键
# pyautogui.click(x=100, y=100, button='left')
##鼠标拖动，参数同上
# pyautogui.mouseDown()
# pyautogui.mouseUp()
##鼠标滚动(滚动次数, x, y)
# pyautogui.scroll(10, x=100, y=100)
# Linux和Macos上，可以用vscroll()实现水平滚动

##键盘控制
# pyautogui.write('hello')
##键盘按下弹起，press = keyDown + keyUp
# pyautogui.press('enter')
# pyautogui.keyDown('e')
# pyautogui.keyUp('e')
# 多按几次
# pyautogui.press('e', presses=3, interval=0.2)
##上下文管理器？
# with pyautogui.hold('shift'):
#     pyautogui.press('e', presses=3)

##消息框，返回单击的按钮的文本
# pyautogui.alert(title='title', text='text', button='好的')
# 确认框，返回单击的按钮的文本
# pyautogui.confirm(text='', title='', buttons=['是', '否'])
# 输入框，返回输入的文本，如果单击取消，则返回 None
# pyautogui.prompt(text='text', title='title' , default='')
# 密码框，返回输入的文本，如果单击取消，则返回 None
# pyautogui.password(text='', title='', default='', mask='*')

##截图，1080p截图耗时100ms
# img = pyautogui.screenshot('my_screenshot.png')
# img = pyautogui.screenshot(region=(0,0,100,100))
##定位(confidence需要openCV支持)
# btn8location = pyautogui.locateOnScreen('eight.png', confidence=0.9)
# btn8x, btn8y = pyautogui.center(btn8location)
# pyautogui.click(btn8x, btn8y)
# 定位到图片中心(confidence 相似度，需要配合openCV)(region 划定范围)(grayscale 灰度匹配)
# btn8x, btn8y = pyautogui.locateCenterOnScreen('qq.png', region=(width/4,height-80,width/3,height), grayscale=True)
# pyautogui.click(btn8x, btn8y)
##像素匹配（返回RGB数组）
# pix = pyautogui.pixel(100, 200)
# pixRes = pyautogui.pixelMatchesColor(100, 200, (140, 125, 134), tolerance=10)
