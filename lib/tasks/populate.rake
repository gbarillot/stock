task populate: :environment do
  require 'csv'
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/svg_outputter'

  User.destroy_all
  Product.destroy_all
  Order.destroy_all
  Position.destroy_all
  Basket.destroy_all
  History.destroy_all

  puts "Users"
  User.Create!(
    email: 'guillaume@demo.com',
    first_name: 'Guillaume',
    last_name: 'Barillot',
    password: '04mars1974',
    password_confirmation: '04mars1974'
  )

  puts 'Products----------------'

  empty_p = Product.create!(reference: '0000', name: 'Vide', quantity: 0, notes: 'default product')

  barcode = Barby::Code128B.new('000000')
  Product.create!(name: 'vide', reference: '000000', ean13: barcode.to_svg(xdim:2, height:60))

  csv_text = File.read("#{Rails.root}/lib/assets/items.csv")
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    ref = row[0]
    name= row[2]
    barcode = Barby::Code128B.new(ref)

    Product.create!(name: name, reference: ref, ean13: barcode.to_svg(xdim:2, height:60))
  end

  puts 'Tree----------------'

  parent = ''
  sampled = []
  ['A', 'B', 'C', 'D'].each do |allee|
    parent = allee
    Position.create!(name: "#{parent}", level: 0, quantity: 0, product_id: nil, free: 3200)

    (1..16).each do |rak|
      Position.create!(name: "#{parent} #{rak}", level: 1, quantity: 0, product_id: nil, free: 800)

      (1..4).each do |etage|
        Position.create!(name: "#{parent} #{rak} #{etage}", level: 2, quantity: 0, product_id: nil, free: 200)

        (1..20).each do |pos|
          new_pos = Position.create!(name: "#{parent} #{rak} #{etage} #{pos}", level: 3, quantity: 0, product_id: 0, free: 10)
          sampled.push(new_pos.id)
        end
      end
    end
  end

  puts 'Populating----------------'
  from = Product.first.id
  to = Product.last.id
  $current_user = User.first

  2000.times do |i|
    p = rand(from..to)
    q = rand(1..10)
    id = sampled.sample
    pos = Position.find(id)
    pos.insert(product_id: p, quantity: q)
  end

end
