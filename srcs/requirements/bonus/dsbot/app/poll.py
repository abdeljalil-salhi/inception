from discord import Embed
from globals import POLL_OPTIONS_EMOJIS, SENT_MESSAGE_IDS

# !create_poll test??; zdzJSZqj dzdzea fdfzsafa ??; wahed, joj, tlata; 15

def validate_params(name, question, options, countdown):
    if name=="":
        return "Poll name shouldn't be empty"
    if len(name)>=20:
        return "Name shouldn't be more than 15 characters"
    if question=="":
        return "Question shouldn't be empty"
    if len(options)<=1:
        return "There must be a minimum of 2 options"
    if len(options)>5:
        return "Maximum options allowed are 5"
    if not isinstance(countdown, int):
        return "Countdown value must be integer"
    return None

async def create_poll(message):
    params = message.content.split(";")
    name = params[0].replace("!create_poll", "").strip()
    question = params[1].strip()
    options = [x.strip() for x in params[2].strip().split(",")]
    options_count = len(options)
    countdown = int(params[3].strip())
  
    error = validate_params(name, question, options, countdown)
 
    if error is not None:
        embed = Embed(title="Error", description=error, color=0xff0000)
        await message.channel.send(embed=embed)
    
    embed = Embed(title=f"POLL: {name}", description=f"**{question}\n{options}**", color=0x12ff51)
    sent = await message.channel.send(embed=embed)
 
    for i in range(options_count):
        await sent.add_reaction(POLL_OPTIONS_EMOJIS[i])
  
    SENT_MESSAGE_IDS.append(message.id)
