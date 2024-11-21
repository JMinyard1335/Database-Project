from scripts import insert_pokemon, insert_types, insert_regions, insert_gyms, insert_pokemon_types, insert_trainers

if __name__ == '__main__':
    insert_pokemon.insert_pokemon_from_csv('csvdata/kanto_pokemon.csv')
    insert_types.insert_types_from_csv('csvdata/types.csv')
    insert_regions.insert_region_from_csv('csvdata/regions.csv')
    insert_pokemon_types.insert_pokemon_types_from_csv("csvdata/pokemontypes.csv")
    insert_gyms.insert_gyms_from_csv('csvdata/gyms.csv')
    insert_trainers.insert_trainers_from_csv('csvdata/gymleader.csv')
    insert_trainers.insert_trainedby_from_csv('csvdata/trainedby.csv')
    
