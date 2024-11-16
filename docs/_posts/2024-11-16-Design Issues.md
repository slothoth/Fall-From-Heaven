---
layout: post  
title: "Design Issues"  
date: 2024-11-16 00:30:00 -0000
categories: Design  
---

This is where I will detail current issues that are awkward about porting this mod to Civ VI, and where I'm not fully satisfied with my solution:

# Civics Tree
The Civics Tree was first implemented for a silly reason, that I couldnt fit all the techs on the tech tree UI that we currently have. I now know enough Lua to easily fix that, but I still think Civics are a good idea, or at least an interesting one.

I spent some considerable time thinking what techs would be good as civics. This has mostly panned out well, barring some odd things it causes like Knowledge of the Ether being available from turn 1 as both Ancient Chants and Education are under civics. The same applies to the Duin tech, it has no tech prereq, and it and its following techs fit well under the civics tree.

I COULD do some hidden dummy techs/civics that are granted to the player on them researching a prerequisite civic/tech in the other tree. I have some prior experience with that. However I worry it will be unclear somewhat, that kinda thing is a last resort.

# Dealing with Districts
Civ IV had all the buildings contained within the city centre, unlike the way civ VI does it with districts. Technically its simple to move all the buildings into the city centre.

The problem comes with niche cases and art.

The first problem is that the Specialist system in Civ VI is distinctly different. Yes you can assign pops to be specialists, but only if you have a district for that specialist. So we need districts. Luckily we can fill all the Specialist types, Sage/Priest/Engineer/Merchant/Artist with Campus/HolySite/IndustrialZone/CommercialHub/TheatreSquare. In addition, buildings that allow assigning additional specialists need to be in the district the specialist is from.

Second, it would be a huge endeavour to fit some 50 odd buildings in the city centre. there isn't procedural placement possible, so I would have to manually add attachment points for all the building and make sure they dont collide.

I had considered making it so the first building of each class was the district itself, but what if you are building out of order? What if you want a library, but not an elder council?
My current solution is to make districts incredibly cheap, but also worthless without the buildings they contain. We shall see how the AI manages it.

# Eurekas
Civ IV never had any Eurekas, so I would have to make them bespoke. I may be able to use them to represent connections between the now divided tech/civic tree. For example, since Knowledge of the Ether is a Tech, but its precursor Education is a civic, I could make having the Education civic be the eureka for KoTE.

# City States
City States didn't exist in FFH or Civ IV. But they are a really cool idea. If we did want to implement it, we would need to design city states. I am thinking of doing something a bit like Fuzzle's Civilizations as City States or how Age of Wonders does it, just make a single city state for each civ. I'm not sure what each should give as a suzerain award though.

# Amenity/Happiness vs Housing/Health
The system of Happiness and Health in FFH doesn't quite port to Amenities and Housing.

Happiness is the ultimate gate of a city size in FFH, if your pop is more than your happiness, you don't get any benefit to those extra population. On the other hand, Amenities just give you a % bonus or % minus yields according to your amenity amount vs amenity need difference.

Housing is closer to Happiness, as it reduces growth when housing need is more than housing total.

Health does control growth, reducing food yield for each population above the health threshold.

We can see the issues with wonders like the Tower of Complacency. It basically gives you infinite happiness, so a city can grow forever. However, the equivalent in Civ VI gives like +100 amenities, but that doesn't ever really help.

In addition, Civ VI over-prioritises settling on rivers, because Housing is so important, although we could just have that in this port.

Replacing this system would suck, as we would have to set amenities to always be neutral somehow, probably GlobalParameters if it exists. 

I'd then have to change the amenity stuff in the UI, and could replace that with our custom one.

# Trade Routes
With the proposed district changes, trade routes will either be overpowered, or underpowered. If we leave it as is, all cities can just build as many districts as possible for free, and each gives an increase in yields to trade routes. But if we remove all trade route district yields, then those trade routes will never scale from the early to the late game. Annoyingly its not that easy to modify trade route yields.

# Damage Conversion
Civ IV had a much smaller damage scale, where a 4 damage unit was quite a bit stronger than a 3 damage unit. This mattered because of % scaling.
Since % scaling is not possible in Civ VI, and existing values like crossing a river, city strengths are kept the same, we needed to upscale the old units strength, multiplying them by 5.
We also made 20% damage increases just +4 damage, which does mean the damage isnt as well represented at high strength amounts.

I did attempt to mathematically solve how I could get the same effect from a combat in Civ VI vs FFH, and it was so unintelligible and unsolvable I gave up. See below:
![Alt text](/Fall-From-Heaven//Images/DamageModelAttempt.png)


