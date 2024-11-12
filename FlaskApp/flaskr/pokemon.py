from flask import Blueprint, request, jsonify, current_app, render_template, redirect, url_for
import sqlite3

pokemon_bp = Blueprint('pokemon', __name__, url_prefix='')


def db_connection():
    conn = sqlite3.connect(current_app.config['DATABASE'])
    conn.row_factory = sqlite3.Row
    return conn


@pokemon_bp.route('/', methods=['GET'])
def get_all_pokemon():
    conn = db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Pokemon")
    rows = cursor.fetchall()
    pokemon_list = [dict(row) for row in rows]
    print(pokemon_list)
    conn.close()
    return render_template('pokemon.html', pokemon_list=pokemon_list)


@pokemon_bp.route('/<int:id>', methods=['GET'])
def get_pokemon(id):
    conn = db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Pokemon WHERE PokeID = ?", (id,))
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
    cursor.execute("INSERT INTO Pokemon (PokeID, PokeNum, Pname, RegionID, Image) VALUES (?, ?, ?, ?, ?)",
                   (poke_id, poke_num, name, region_id, image))
    conn.commit()
    conn.close()
    return redirect(url_for('pokemon.get_all_pokemon'))


@pokemon_bp.route('/<int:id>/delete', methods=['POST'])
def delete_pokemon(id):
    conn = db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Pokemon WHERE PokeID = ?", (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('pokemon.get_all_pokemon'))


