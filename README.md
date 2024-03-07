# dvmapp

A new Pokedex app that uses PokeAPI.

## TASK

I have created a Pokédex app. Here are all the functionalities the app contains:

1. Show the name, image, type, number, and description of the Pokémon.
2. All details about the Pokémon must be fetched from PokéAPI’s APIs.
3. All details fetched from API must be stored locally. If I do not have an internet connection and restart the app, the data for those Pokémon that have already been downloaded will be shown.
4. UI: [Pokedex Recruitment Design](https://www.figma.com/file/2ebpKoyjQxZnH3hDMupmCW/DVM-APP-SEM-2?type=design&node-id=0%3A1&mode=design&t=sRqWaNGY2dCQNg6a-1)
5. I can filter the Pokémon by type, such as Grass, Fire, and Water.
6. I can search the Pokémon by name.
7. Add a splash screen and app icon.

**BUG [1]**

Loading time is high as it has to go through 300+ separate websites to parse their data to get description for each pokemon
