from configparser import ConfigParser
from dotenv import load_dotenv
from os import getenv

CONFIG_FILE = "config.ini"

def get_id(key: str) -> int:
    _parser = ConfigParser()
    _parser.read(CONFIG_FILE)
    return int(_parser["DEFAULT"][key])

def get_config(key: str) -> str:
    _parser = ConfigParser()
    _parser.read(CONFIG_FILE)
    return _parser["DEFAULT"][key]

load_dotenv()
cparser = ConfigParser()
cparser.read(CONFIG_FILE)

POLL_OPTIONS_EMOJIS = ["1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣"]
SENT_MESSAGE_IDS = []
DISCORD_TOKEN = getenv("DISCORD_TOKEN")

