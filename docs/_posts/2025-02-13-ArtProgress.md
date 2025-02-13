---
layout: post  
title: "VFX Units, Custom Behaviours"  
date: 2025-02-13 01:30:00 -0000
categories: Art  
---

Hullo again! its been about three months since i posted, but its been a busy time. I have been deep into making art and assets and all sorts of polish.

I've made icons for all of the mana resources, some of which I had some help using AI image generation, as I am no artist, but there was still a lot of massaging done to fix things. Hopefully they are still high quality, but I would be happy to accept contributions to replace them, as I know some people object to AI generation.
![Mana Resources!](/Fall-From-Heaven//Images/resources_one.png)
![Mana Resources!](/Fall-From-Heaven//Images/resources_two.png)
![Mana Resources!](/Fall-From-Heaven//Images/resources_three.png)
I've also began to incorporate some of the equipment and pieces made by the excellent team at Warfare Expanded. Without their work, I would be bogged down making tons of assets for the specific period of history, greataxes, hammers, horned helmets, feudal yeoman armor, the list goes on.
![Pictured from left to right, top down: Archer, Maros, Flurry, Gilden, Mimic, Firebow, NightWatch, Arthedain, Crusader, Longbowman, Orthus, Basium, Beastmaster, Demagog](/Fall-From-Heaven//Images/bowmanwarfare.png)

For the animal assets, I've absorbed units from the Wildlife mod, which adds animal units like Bears and Wolves to the game. Those themselves were taken from Wildlife park 2, but there was a lot of work setting up animations I imagine. I still have some missing animals like the Giant Spider (luckily those don't exist in wildlife parks, or in real life!)
![Dragons were adapted from Prehistoric Wildlife's TRex. I plan to put on wings and add some fire breathing!](/Fall-From-Heaven//Images/wildlife.png)

I've also taken a lot of icon assets from the great people at Game-Icons.net. Its a free project producing high quality icons, and I couldn't have made the 200 odd UnitFlags without them.
![The huge woman is just for dev, that asset is closed source, so I can't preview it except in game.](/Fall-From-Heaven//Images/icons_one.png)
![](/Fall-From-Heaven//Images/icons_two.png)


Its funny, with that and Warfare Expanded assets, you would think its just like pre-assembled legos, but its been a lot of work cataloguing each unit, thinking of a good icon, worrying about overly similar icons. And its been a total maze navigating the Warfare Expanded assets, since theres likes hundreds of assets, and i can only view one at a time.


I've also ported the civ flags/icons and leaderheads to Civ VI. The flags maybe look a little different due to all the processing, I used a vector converter (https://vectormagic.com/) to get them to a SVG format, and then had to manually go in and adjust some paths.

![Resource icons are currently not working on the frontend, hence the weird clipping.](/Fall-From-Heaven//Images/setup_screen.png)


The leaderheads are an interesting one. They are only 512x512, and do not fit the VI style at all. But the art has such a distinct aesthetic, I can't bring myself to use some AI tools to replace them.
![](/Fall-From-Heaven//Images/load_screen.png)
![](/Fall-From-Heaven//Images/sheelba_diplo.png)


For my own home grown assets, I have also been busy. One such example is the Centaur units for the Kuriotates. It was a lot of work, basically remodelling the horse unit and attaching a human torso. Then having to combine all the animations of the Horse, and the Rider (they are separate units). There was a lot of pains there, and I'm still not 100% happy with it. I did try a funky version where I had a headless horse and a legless rider, but it all fell apart when the horse would turn, as due to the way rotations work, and the fact the rider is meant to be in the centre, the torso briefly is left completely free floating in the air. Not ideal.

![img.png](/Fall-From-Heaven//Images/Custom_Units.png)

I also made goat legs, they were my second ever asset, and i very much underestimated my poly count budget, so they are very low poly. I plan to make a better version, and also a better fur texture on them down the line.

Other examples include the golem units, which have been more reskinning of a buff male body asset. I also lack the skill to texture paint well, so have been working with an AI image generation tool, Invoke, which allows for some fine grained control over generation.

My first attempt involved trying to position my unit in 3d space with consistent camera angles, then use that image with a depth model to generate the character in a t pose but with a texture using a prompt. That went very poorly, so instead i pivoted to pulling out the existing albedo texture maps, and prompting for things like wood, golem, etc. It did create some horror shows (bottom up view is not a good line in a prompt if you dont have the GPU memory budget for the NSFW filter), but it did generate some good results, which I then did some work in GIMP to correct the edge cases, and blend the UV islands.

Using that, I made a Wood Golem, an Iron Golem, the Stygian Guard and the Lizardman body. For the time being until I make an animation set(lots of work) they have clubs like warriors.

I also made the Lizardman model, a very important one, as we all have experienced constant Lizardman harassment from Ruins. That used that Lizardman body, and added the head of a T-rex from Deliverators Prehistoric Wildlife. Animating the head is still in progress, but its not too noticeable.

I also have been working on what I thought would be a very difficult problem, the VFX units like Fire Elementals, Air Elementals, Pyre Zombies. I managed to get persistent VFX on units, which in the case of the Elementals, is all they are. The Air elemental is the pre-existing Tornado natural disaster, the Fire Elemental and Fireball are various Fire VFX scaled up. Some were harder, like the lightning elemental. Civ VI developed a scripting language based on C, and so I was able to go in and edit existing VFX, like the hurricane to only include the dark storm clouds seen below:

<video width="560" height="315" controls>
  <source src="/Fall-From-Heaven//Video/lightning.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

<video width="560" height="315" controls>
  <source src="/Fall-From-Heaven//Video/hi_def_movement_tornado_centaur_fire.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

I never got around to it, but the work on projects like StableProjectorz seems very promising, although my 1660 SUPER is struggling already running StableDiffusion1.5.


There also has been some work on other VFX, like the Pyre Zombie. In Civ IV he was a warrior reskinned with a burnt texture and flames. I can do the flames, but I also thought it was one of the most gruesome and coolest ideas, a zombie aflame from its own rendered dripping fat. So I took a lava texture, applied a motion to it overtime so it would "drip" and also included the Volcano eruption VFX. It doesnt really sell as a Pyre Zombie, but its pretty darn cool, kinda like Sutr from Thor Ragnarok. I think i will go back to a flame, and also adjust the texture to be more human and burnt skin/fat. But its such a specific thing it will probably be hard to find textures for it. 

<video width="560" height="315" controls>
  <source src="/Fall-From-Heaven//Video/fire_cape_fail_pyre_zombie.mp4" type="video/mp4">
</video>


I've also gone through and given sensible defaults to units that dont have assets yet, so like the Hornguard, which is meant to be a Rhino cavalry, uses the Knight model. Rather than before when it used the Warrior model.

I'm hoping to put out an Alpha very soon, so other people can give me some feedback. Don't expect it to be stable however, I am not at that point yet.
