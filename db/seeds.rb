# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
title = Faker::Book.title
author = Faker::Book.author
pages = Fake::Number.within(10,1000)
year = Faker::Number.within(1800,2018)
book_1 = Book.create(title: title, author: author, pages: pages, year: year)
