musician(jota, guitar).
musician(jota, vocals).
musician(m_ward, guitar).
musician(m_ward, vocals).
musician(zooey, vocals).
musician(eric, drum).
musician(jarvis, vocals).
musician(john, guitar).

genre(jota, pop).
genre(m_ward, folk).
genre(zooe, folk).
genre(eric, pop).
genre(john, jazz).
genre(jarvis, pop).

musician_instrument_and_genre(Musician, Instrument, Genre) :- musician(Musician, Instrument), genre(Musician, Genre).
