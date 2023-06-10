from discord import Intents, File, Game
from discord.ext import commands
from discord_slash import SlashCommand
from poll import create_poll
from globals import DISCORD_TOKEN, get_id
from slash import SlashCommands

class Abdelz(commands.Cog):
    def __init__(self, client: commands.Bot) -> None:
        self.client = client

    @commands.Cog.listener()
    async def on_ready(self) -> None:
        await self.client.change_presence(activity=Game(name="with myself :3"))
        print("Bot is up and running.")
        channel = self.client.get_channel(int(get_id("LOGS_CHANNEL")))
        await channel.send("Yo wassup, I'm back ! :3") if channel is not None else print(f"LOGS_CHANNEL [#{get_id('LOGS_CHANNEL')}] not found.")
                    
    @commands.command()
    async def help(self, ctx) -> None:
        await ctx.send("```!create_poll <name>; <question>; <choice1>, <choice2>, <choiceN>; <time>```")

    @commands.Cog.listener()
    async def on_message(self, message) -> None:
        if message.content == "ping":
            await message.channel.send("pong")
        elif message.content == "hello":
            await message.channel.send("hi")
        elif message.content.startswith("!create_poll"):
            await create_poll(message)
        elif message.content == "config":
            await message.channel.send(f"```LOGS_CHANNEL: {get_id('LOGS_CHANNEL')}```")
        elif message.content.startswith("w9"):
            await message.channel.send("mok kbirthom hh")
        elif ("wydad" in message.content or "widad" in message.content) and "dima" in message.content:
            await message.channel.send("o ga3 jrad wlad lqhab")
        elif message.content == "afk":
            await message.channel.send(f"{message.author.mention} is now afk")

    @commands.Cog.listener()
    async def on_member_join(self, member) -> None:
        channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if channel is not None:
            await channel.send(f"Welcome {member.mention} to the server!")
            await channel.send(file=File("welcome.jpg"))
    
    @commands.Cog.listener()
    async def on_member_remove(self, member) -> None:
        channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if channel is not None:
            await channel.send(f"{member.mention} has left the server.")

    @commands.Cog.listener()
    async def on_message_delete(self, message) -> None:
        channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if channel is not None:
            await channel.send(f"{message.author.mention} has deleted the message: {message.content}")
    
    @commands.Cog.listener()
    async def on_message_edit(self, before, after) -> None:
        if before.author != self.client.user:
            channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
            if channel is not None:
                await channel.send(f"{before.author.mention} has edited the message: {before.content} to {after.content}")

    @commands.Cog.listener()
    async def on_raw_reaction_add(self, payload) -> None:
        channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if channel is not None:
            await channel.send(f"{payload.member.mention} has added a reaction to {payload.message_id}")

    @commands.Cog.listener()
    async def on_member_update(self, before, after) -> None:
        if before.nick != after.nick:
            channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
            if channel is not None:
                await channel.send(f"{before.mention} has changed their nickname to {after.nick}")
        if before.status != after.status and (after.status == "online" or after.status == "idle" or after.status == "dnd") and before.status == "offline":
            channel = self.client.get_channel(get_id("STATUS_CHANNEL"))
            if channel is not None:
                await channel.send(f"{before.mention} is now online :3 (status: {after.status})")

    @commands.Cog.listener()
    async def on_voice_state_update(self, member, before, after) -> None:
        channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if channel is not None:
            if before.channel != after.channel:
                if before.channel is None:
                    await channel.send(f"{member.mention} has joined the voice channel {after.channel.name}")
                elif after.channel is None:
                    await channel.send(f"{member.mention} has left the voice channel {before.channel.name}")
                else:
                    await channel.send(f"{member.mention} has switched from the voice channel {before.channel.name} to {after.channel.name}")
        
    @commands.Cog.listener()
    async def on_guild_channel_create(self, channel) -> None:
        ch = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if ch is not None:
            await ch.send(f"{channel.name} has been created.")
    
    @commands.Cog.listener()
    async def on_guild_channel_delete(self, channel) -> None:
        ch = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if ch is not None:
            await ch.send(f"{channel.name} has been deleted.")
    
    @commands.Cog.listener()
    async def on_guild_channel_update(self, before, after) -> None:
        channel = self.client.get_channel(get_id("LOGS_CHANNEL"))
        if channel is not None and before.name != after.name:
            await channel.send(f"{before.name} has been renamed to {after.name}")

if __name__ == "__main__":
    client = commands.Bot(command_prefix="/", intents=Intents.all(), help_command=None)
    client.add_cog(Abdelz(client))
    slash = SlashCommand(client, sync_commands=True)
    SlashCommands(client, slash)
    client.run(DISCORD_TOKEN, bot=True, reconnect=True)
