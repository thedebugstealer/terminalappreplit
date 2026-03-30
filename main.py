from kivymd.app import MDApp
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.scrollview import ScrollView
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput

class Terminal(BoxLayout):
    def __init__(self, **kwargs):
        super().__init__(orientation="vertical", **kwargs)

        self.scroll = ScrollView(size_hint_y=0.85)
        self.output = Label(
            text="",
            markup=True,
            font_size=16,
            halign="left",
            valign="top"
        )
        self.output.bind(texture_size=self.output.setter("size"))
        self.scroll.add_widget(self.output)

        self.input = TextInput(
            size_hint_y=0.15,
            multiline=False,
            font_size=16,
            background_color=(0, 0, 0, 1),
            foreground_color=(0, 1, 0, 1),
            cursor_color=(0, 1, 0, 1)
        )
        self.input.bind(on_text_validate=self.run_command)

        self.add_widget(self.scroll)
        self.add_widget(self.input)

    def run_command(self, instance):
        cmd = self.input.text.strip()
        self.output.text += f"[color=00ff00]> {cmd}[/color]\n"
        self.input.text = ""

        response = self.handle(cmd)
        self.output.text += f"{response}\n"

        self.scroll.scroll_y = 0

    def handle(self, cmd):
        if cmd == "help":
            return "[color=00ff00]Commands: help, ping, clear[/color]"
        if cmd == "ping":
            return "[color=00ff00]pong[/color]"
        if cmd == "clear":
            self.output.text = ""
            return ""
        return f"[color=ff0000]Unknown command: {cmd}[/color]"

class TerminalApp(MDApp):
    def build(self):
        self.theme_cls.theme_style = "Dark"
        return Terminal()

TerminalApp().run()
