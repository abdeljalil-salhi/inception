from discord.ext import commands
from discord_slash import SlashContext, SlashCommand
from datetime import datetime
from config import ConfigCommands

class SlashCommands:
    def __init__(self, client: commands.Bot, slash: SlashCommand) -> None:
        
        ConfigCommands(client, slash)
        
        @slash.slash(name="ping", description="Ping the bot")
        async def ping(ctx: SlashContext) -> None:
            await ctx.send(f"Ping: {round(client.latency * 1000)}ms", hidden=True)
            
        @slash.slash(name="shutdown", description="Shutdown the bot")
        async def shutdown(ctx: SlashContext) -> None:
            if ctx.author.guild_permissions.administrator:
                await ctx.send("Shutting down...", hidden=True)
                if ctx.guild.voice_client is not None:
                    await ctx.guild.voice_client.disconnect()
                await client.close()
            else:
                await ctx.send("SIKE !! You don't have the permission to do that", hidden=True)
            
        @slash.slash(name="avatar", description="Get the avatar of a user", options=[{"name": "user", "description": "The user to get the avatar of", "type": 6, "required": False}])
        async def avatar(ctx: SlashContext, user=None) -> None:
            await ctx.send(f"{user.avatar_url if user else ctx.author.avatar_url}", hidden=True)
            if user and user.status != "offline" and user != client.user:
                await user.send(f"DING DING {user.mention} !! {ctx.author.mention} just checked your avatar :3")
                
        @slash.slash(name="check_activity", description="Check the activity of a user", options=[{"name": "user", "description": "The user to check the activity of", "type": 6, "required": False}])
        async def check_activity(ctx: SlashContext, user=None) -> None:
            if user:
                if user.status != "offline" and user != client.user:
                    if user.activity is not None:
                        activity_time = datetime.utcnow() - user.activity.created_at
                        if activity_time.total_seconds() >= 6 * 60 * 60:
                            await ctx.send(f"{user.name} has been active for more than 6 hours in {user.activity.name}, take some rest.")
            else:
                for member in ctx.guild.members:
                    if member.status != "offline" and member != client.user:
                        if member.activity is not None:
                            activity_time = datetime.utcnow() - member.activity.created_at
                            if activity_time.total_seconds() >= 6 * 60 * 60:
                                await ctx.send(f"{member.name} has been active for more than 6 hours in {member.activity.name}, take some rest.")
        
        @slash.slash(name="send_dm", description="Send a DM to a user", options=[{"name": "user", "description": "The user to send the DM to", "type": 6, "required": True}, {"name": "message", "description": "The message to send", "type": 3, "required": True}])
        async def send_dm(ctx: SlashContext, user, message) -> None:
            if ctx.author.guild_permissions.administrator:
                await user.send(message)
                await ctx.send(f"DM sent to {user.mention}", hidden=True)
            else:
                await ctx.send("SIKE !! You don't have the permission to do that", hidden=True)
