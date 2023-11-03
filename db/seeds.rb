# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users= User.create([
					{email:'cgovea@atrareconsultores.com.mx',password:'Atrare2857', password_confirmation:'Atrare2857', admin: :true},
					{email:'mayela.meneses@vitalmex.com.mx',password:'vitalmex123', password_confirmation:'vitalmex123',admin:false},					
					{email:'gabriel.cabrera@vitalmex.com.mx',password:'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email:'flor.miranda@vitalmex.com.mx',password:'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email:'fredy.briones@vitalmex.com.mx',password:'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email:'irma.govea@vitalmex.com.mx',password:'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'jaime.alvarado@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'julio.quintanar@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'marco.hernandez@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'mariana.bellido@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'mmedrano@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'nashieli.carrion@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'omar.sanchez@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'shendel.acevess@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'epantoja@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'abuendia@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'miguel.hernandezc@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'cristopher.olivares@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					{email: 'rodrigo.zunigap@vitalmex.com.mx',password: 'vitalmex123', password_confirmation:'vitalmex123',admin:false},
					
					])
