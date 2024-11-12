import insert_pokemon
import insert_types
import insert_regions
import insert_gyms


if __name__ == '__main__':
    insert_pokemon_from_csv('csvdata/kanto_pokemon.csv')
    insert_types_from_csv('csvdata/types.cvs')
    insert_region_from_csv('csvdata/regions.csv')
    insert_gyms_from_csv('csvdata/gyms.csv')
