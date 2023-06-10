from discord import FFmpegPCMAudio
from discord.ext import commands
from discord.utils import get
from discord_slash import SlashContext, SlashCommand
from youtube_dl import YoutubeDL

class MusicCommands:
    def __init__(self, client: commands.Bot, slash: SlashCommand) -> None:

        @slash.slash(name="play", description="Play a song", options=[{"name": "song", "description": "The song to play", "type": 3, "required": True}])
        async def play(ctx: SlashContext, url: str) -> None:
            YDL_OPTIONS = {'format': 'bestaudio', 'noplaylist': 'True'}
            FFMPEG_OPTIONS = {
                'before_options': '-reconnect 1 -reconnect_streamed 1 -reconnect_delay_max 5', 'options': '-vn'}
            voice = get(client.voice_clients, guild=ctx.guild)
            if voice and voice.is_connected():
                if not voice.is_playing():
                    with YoutubeDL(YDL_OPTIONS) as ydl:
                        info = ydl.extract_info(url, download=False)
                    URL = info['formats'][0]['url']
                    voice.play(FFmpegPCMAudio(URL, **FFMPEG_OPTIONS))
                    voice.is_playing()
                    await ctx.send(f"Playing {info['title']}", hidden=True)
                else:
                    await ctx.send("I am already playing a song", hidden=True)
            else:
                await ctx.send("I am not connected to a voice channel", hidden=True)
        
        @slash.slash(name="join", description="Join the voice channel")
        async def join(ctx: SlashContext) -> None:
            channel = ctx.author.voice.channel
            voice = get(client.voice_clients, guild=ctx.guild)
            await voice.move_to(channel) if voice and voice.is_connected() else await channel.connect()
            
        @slash.slash(name="leave", description="Leave the voice channel")
        async def leave(ctx: SlashContext) -> None:
            voice = get(client.voice_clients, guild=ctx.guild)
            await voice.disconnect() if voice and voice.is_connected() else await ctx.send("I am not connected to a voice channel", hidden=True)

        @slash.slash(name="pause", description="Pause the current song")
        async def pause(ctx: SlashContext) -> None:
            voice = get(client.voice_clients, guild=ctx.guild)
            if voice.is_playing():
                voice.pause()
                await ctx.send("Paused", hidden=True)
            else:
                await ctx.send("I am not playing anything", hidden=True)
            
        @slash.slash(name="resume", description="Resume the current song")
        async def resume(ctx: SlashContext) -> None:
            voice = get(client.voice_clients, guild=ctx.guild)
            if voice.is_paused():
                voice.resume()
                await ctx.send("Resumed", hidden=True)
            else:
                await ctx.send("I am not paused", hidden=True)
        
        @slash.slash(name="skip", description="Skip the current song")
        async def skip(ctx: SlashContext) -> None:
            voice = get(client.voice_clients, guild=ctx.guild)
            if voice.is_playing():
                voice.stop()
                await ctx.send("Skipped", hidden=True)
            else:
                await ctx.send("I am not playing anything", hidden=True)
            
        # @slash.slash(name="clear", description="Clear the queue")
        # async def clear(ctx: SlashContext) -> None:
        #     await music.clear_queue()
            
        @slash.slash(name="volume", description="Set the volume", options=[{"name": "volume", "description": "The volume to set", "type": 4, "required": True}]) 
        async def volume(ctx: SlashContext, volume: int) -> None:
            voice = get(client.voice_clients, guild=ctx.guild)
            if voice and voice.is_connected():
                if 0 < volume < 101:
                    voice.source.volume = volume / 100
                    await ctx.send(f"Volume set to {volume}", hidden=True)
                else:
                    await ctx.send("Volume must be between 0 and 100", hidden=True)
            else:
                await ctx.send("I am not connected to a voice channel", hidden=True)
            