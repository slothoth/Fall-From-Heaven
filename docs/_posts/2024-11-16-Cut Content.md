---
layout: post  
title: "Cut Content"  
date: 2024-11-16 00:30:00 -0000
categories: Design  
---

Some content was either not worth having, or seemed to serve no gameplay mechanic besides being a workaround. For example, a lot of the Doviello units serve no different purpose other than they don't need the prerequisite building to upgrade/build.

# Combat system
## First Strikes
In the civ VI combat system, First strikes unfortunately just don't make sense. They have been replaced with a flat damage bonus.

## % Damage increases
In Civ VI, % increases in combat strength are impossible. As a result, we had to convert the % damage bonuses to flat ones. This will probably need playtesting and some rebalancing.

## Complex elemental damage resistance
As % increases are not possible, so too are % decreases in damage. I have approximately implemented it by doing splitting each 1 Element damage (6 damage in VI) into 6, and then had requirements for each. This means things like Fire immunity work fine, as will abilities like vulnerable to fire or on a unit specific basis. However, there is no requirement that can check if a unit has a specific promotion, so I can't do the base promotions Fire Resistance, Magic Resistance, Poison resistance, Lightning resistance, Cold resistance. Actually as I write this, it might be possible for a promotion to grant an ability to those units, and I can test the ability. Irregardless, I cant do any complicated maths on this.

## Naval transports
As we have the embarking system, we don't need the naval transports previously in Civ. This also means theres not much point in the retrofit system, as the only two options to change are movespeed and combat strength.