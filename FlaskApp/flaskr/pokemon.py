from flask import Blueprint, request, jsonify, current_app, render_template, redirect, url_for
import sqlite3
import os

pokemon_bp = Blueprint('pokemon', __name__, url_prefix='')


def db_connection():
    conn = sqlite3.connect(current_app.config['DATABASE'])
    conn.row_factory = sqlite3.Row
    return conn


@pokemon_bp.route('/', methods=['GET'])
def get_all_pokemon():
    conn = db_connection()
    cursor = conn.cursor()
    query = """
    SELECT 
        p.PokeID, p.PokeNum, p.Pname, 
        r.RegionName, p.Image, 
        GROUP_CONCAT(t.TypeName) AS TypeNames
    FROM 
        Pokemon p
    JOIN 
        Region r ON p.RegionID = r.RegionID
    JOIN 
        PokemonType pt ON p.PokeID = pt.PokeID
    JOIN 
        Typ t ON pt.TypeID = t.TypeID
    GROUP BY 
        p.PokeID, p.PokeNum, p.Pname, r.RegionName;
    """
    cursor.execute(query)
    rows = cursor.fetchall()
    for row in rows:
        print(row)
    pokemon_list = [dict(row) for row in rows]
    print(pokemon_list)
    conn.close()
    return render_template('index.html', pokemon_list=pokemon_list)


@pokemon_bp.route('/<int:id>', methods=['GET'])
def get_pokemon(id):
    conn = db_connection()
    cursor = conn.cursor()
    query = f"SELECT * FROM Pokemon WHERE PokeID = {id}"
    cursor.execute(query)
    row = cursor.fetchone()
    conn.close()
    if row:
        return jsonify(dict(row))
    else:
        return jsonify({'error': 'Pokemon not found'}), 404


@pokemon_bp.route('/new', methods=['GET'])
def new_pokemon():
    return render_template('new.html')


@pokemon_bp.route('/', methods=['POST'])
def create_pokemon():
    poke_id = request.form.get('poke_id')
    poke_num = request.form.get('poke_num')
    name = request.form.get('name')
    region_id = request.form.get('region_id')
    image = request.form.get('image')

    if not all([poke_id, poke_num, name, region_id]):
        return jsonify({'error': 'Missing required fields'}), 400

    conn = db_connection()
    cursor = conn.cursor()

    query = f"""
    INSERT INTO Pokemon (PokeID, PokeNum, Pname, RegionID, Image)
    VALUES ({poke_id}, {poke_num}, "{name}", {region_id}, "{image}")
    """
    cursor.execute(query)
    conn.commit()
    conn.close()
    return redirect(url_for('pokemon.get_all_pokemon'))


@pokemon_bp.route('/<int:id>/delete', methods=['POST'])
def delete_pokemon(id):
    conn = db_connection()
    cursor = conn.cursor()
    query = f"DELETE FROM Pokemon WHERE PokeID = {id}"
    cursor.execute(query)
    conn.commit()
    conn.close()
    return redirect(url_for('pokemon.get_all_pokemon'))

@pokemon_bp.route('/search', methods=['GET'])
def search_pokemon():
    poke_num = request.args.get('pokeNum')
    if not poke_num:
        return redirect(url_for('pokemon.get_all_pokemon'))

    conn = db_connection()
    cursor = conn.cursor()
    query = """
    SELECT 
        p.PokeID, p.PokeNum, p.Pname, 
        r.RegionName, p.Image, 
        GROUP_CONCAT(t.TypeName) AS TypeNames
    FROM 
        Pokemon p
    JOIN 
        Region r ON p.RegionID = r.RegionID
    JOIN 
        PokemonType pt ON p.PokeID = pt.PokeID
    JOIN 
        Typ t ON pt.TypeID = t.TypeID
    WHERE 
        p.PokeNum = ?
    GROUP BY 
        p.PokeID, p.PokeNum, p.Pname, r.RegionName;
    """
    cursor.execute(query, (poke_num,))
    rows = cursor.fetchall()
    conn.close()

    if not rows:
        return render_template('index.html', error="No Pokémon found with that PokeNum", pokemon_list=[])

    pokemon_list = [dict(row) for row in rows]
    return render_template('index.html', pokemon_list=pokemon_list)

@pokemon_bp.route('/<int:id>/edit', methods=['GET'])
def edit_pokemon(id):
    conn = db_connection()
    cursor = conn.cursor()
    query = "SELECT * FROM Pokemon WHERE PokeID = ?"
    cursor.execute(query, (id,))
    pokemon = cursor.fetchone()
    conn.close()
    if pokemon:
        return render_template('edit.html', pokemon=dict(pokemon))
    else:
        return jsonify({'error': 'Pokemon not found'}), 404

@pokemon_bp.route('/<int:id>/update', methods=['POST'])
def update_pokemon(id):
    poke_num = request.form.get('poke_num')
    name = request.form.get('name')
    region_id = request.form.get('region_id')
    image = request.form.get('image')

    if not all([poke_num, name, region_id]):
        return jsonify({'error': 'Missing required fields'}), 400

    conn = db_connection()
    cursor = conn.cursor()
    query = """
    UPDATE Pokemon
    SET PokeNum = ?, Pname = ?, RegionID = ?, Image = ?
    WHERE PokeID = ?
    """
    cursor.execute(query, (poke_num, name, region_id, image, id))
    conn.commit()
    conn.close()
    return redirect(url_for('pokemon.get_all_pokemon'))


 # ASSIGNMENT 5 STUFF   
@pokemon_bp.route('/assignment5', methods=['GET', 'POST'])
def assignment5():
    if request.method == 'POST':
        if 'search_submit' in request.form:
            return search_pokemon_unsafe()
        elif 'update_submit' in request.form:
            return update_pokemon_unsafe()
        elif 'search_safe_submit' in request.form:
            return search_pokemon_safe()
    
    return render_template('assignment5.html')

# Part A: SQL Injection (SELECT)
def search_pokemon_unsafe():
    pokemon = None
    error = None

    poke_id = request.form.get('poke_id')
    
    if not poke_id:
        return render_template('assignment5.html', error="Pokémon ID is required")
    
    # Vulnerable SQL search query
    query = f"SELECT * FROM Pokemon WHERE PokeID = {poke_id}"
    unsafe_query = f"sqlite3 {current_app.config['DATABASE']} \"{query}\""
    
    # Execute the raw query in the shell
    result = os.popen(unsafe_query).read()

    if not result:
        error = "No Pokémon found with that ID"
    else:
        pokemon = result

    return render_template('assignment5.html', pokemon=pokemon, error=error)

# Part B: SQL Injection (UPDATE)
def update_pokemon_unsafe():
    poke_id = request.form.get('poke_id')
    poke_name = request.form.get('poke_name')
    success_message = None
    error = None

    if not poke_id or not poke_name:
        return render_template('assignment5.html', error="Both Pokemon ID and Name are required")

    # Vulnerable UPDATE query
    query = f"UPDATE Pokemon SET Pname = '{poke_name}' WHERE PokeID = {poke_id}"
    unsafe_query = f"sqlite3 {current_app.config['DATABASE']} \"{query}\""
    
    # Execute the raw query in the shell
    result = os.popen(unsafe_query).read()

    if not result:
        error = "Failed to update Pokémon"
    else:
        success_message = f"Pokemon {poke_id} updated successfully."

    return render_template('assignment5.html', success_message=success_message, error=error)

# Part C: Prepared Statements to Prevent SQL Injection
def search_pokemon_safe():
    pokemon = None
    error = None

    poke_id = request.form.get('poke_id')
    
    if not poke_id:
        return render_template('assignment5.html', error="Pokémon ID is required")
    
    # Use prepared statements to prevent SQL injection
    conn = db_connection()
    query = "SELECT * FROM Pokemon WHERE PokeID = ?"
    cursor = conn.execute(query, (poke_id,))
    result = cursor.fetchall()

    if not result:
        error = "No Pokémon found with that ID"
    else:
        pokemon = result

    return render_template('assignment5.html', pokemon=pokemon, error=error)
