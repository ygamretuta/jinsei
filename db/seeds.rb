# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Category.create([
  {:name=>'Plastic Modeling Kits', :description=>'', :slug=>'plastic-modeling-kits'},
  {:name=>'Photography', :description=>'', :slug=>'photography'},
  {:name=>'Computer Hardware and Software', :description=>'', :slug=>'computer-software-hardware'},
  {:name=>'Consoles and Electronic Gaming', :description=>'', :slug=>'consoles-gaming'},
  {:name=>'Entertainment: Movies, TV Series, Audio', :description=>'', :slug=>'movies-tv-series-audio'},
  {:name=>'Books and Literature', :description=>'', :slug=>'books-literature'},
  {:name=>'Construction Hardware and Tools', :description=>'', :slug=>'construction-hardware-tools'},
  {:name=>'Children\'s Toys and Board Games', :description=>'', :slug=>'children-toys-board-games'},
  {:name=>'Fashion and Clothing', :description=>'', :slug=>'fashion-clothing'},
  {:name=>'Arts and Handicrafts', :description=>'', :slug=>'arts-handicrafts'},
  {:name=>'Furnitures and Decorations', :description=>'', :slug=>'furnitures-decorations'},
  {:name=>'Appliances', :description=>'', :slug=>'appliances'},
  {:name=>'Gadgets and Communication Devices', :description=>'', :slug=>'gadgets-telecommunications-devices'},
  {:name=>'Agriculture and Pets', :description=>'', :slug=>'agriculture-pets'},
  {:name=>'Automobile Parts and Tools', :description=>'', :slug=>'automobile-parts-tools'},
  {:name=>'Music Instruments and Audio Systems and Tools', :description => '', :slug=>'music-instruments-audio-system-tools'},
  {:name=>'Antiques and Collectibles', :description => '', :slug => 'antiques-and-collectibles'}
])