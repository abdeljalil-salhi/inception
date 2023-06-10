from discord import TextChannel
from discord.ext import commands
from discord_slash import SlashContext, SlashCommand
from globals import CONFIG_FILE

class ConfigCommands:
    def __init__(self, client: commands.Bot, slash: SlashCommand) -> None:
        
        @slash.slash(name="set_logs_channel", description="Set the logs channel", options=[{"name": "channel", "description": "The channel to set as the logs channel", "type": 7, "required": True}])
        async def set_logs_channel(ctx: SlashContext, channel: TextChannel) -> None:
            if ctx.author.guild_permissions.administrator:
                await ctx.send(f"Logs channel set to {channel.mention} [#{channel.id}]", hidden=True)
                with open(CONFIG_FILE, "r") as f:
                    lines = f.readlines()
                with open(CONFIG_FILE, "w") as f:
                    for line in lines:
                            f.write(f"LOGS_CHANNEL={channel.id}\n") if line.startswith("LOGS_CHANNEL") else f.write(line)
            else:
                await ctx.send("SIKE !! You don't have the permission to do that", hidden=True)

        @slash.slash(name="set_status_channel", description="Set the status channel", options=[{"name": "channel", "description": "The channel to set as the status channel", "type": 7, "required": True}])
        async def set_status_channel(ctx: SlashContext, channel: TextChannel) -> None:
            if ctx.author.guild_permissions.administrator:
                await ctx.send(f"Status channel set to {channel.mention} [#{channel.id}]", hidden=True)
                with open(CONFIG_FILE, "r") as f:
                    lines = f.readlines()
                with open(CONFIG_FILE, "w") as f:
                    for line in lines:
                            f.write(f"STATUS_CHANNEL={channel.id}\n") if line.startswith("STATUS_CHANNEL") else f.write(line)
            else:
                await ctx.send("SIKE !! You don't have the permission to do that", hidden=True)
