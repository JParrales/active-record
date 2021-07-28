# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  title      :string
#  code       :string
#  stock      :integer          default(0)
#  price      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord

    #save
    before_create :validate_product
    after_create :send_notification
    after_save :push_notification, if: :discount?

    validates :title, presence: {message: 'Es necesario definir un valor para el titulo'}
    validates :code, presence: {message: 'Es necesario definir un valor para el codigo'}

    validates :code, uniqueness: {message: 'El codigo %{value} se encuentra en uso'}

    validates_with ProductValidator

    scope :available, -> (min=1){ where('stock >= ?', min) }
    scope :order_price, -> { order('price DESC')}
    scope :available_and_order_price_desc, -> { availabe.order_price}

    def total
        self.price * 3500
    end

    def discount?
        self.total < 50000
    end

    def self.top_5_available
        self.available.order_price.limit(5).select(:title, :code)
    end

    private 

    def validate_product
        puts "\n\n\n>>> Un nuevo producto será añadido a almacen"
    end

    def send_notification
        puts "\n\n\n>>> Un nuevo producto fue añadido a almacen: #{self.title} - $#{self.total} COP"
    end

    def send_notification
        puts "\n\n\n>>> Un nuevo producto fue añadido a almacen: #{self.title} - $#{self.total} COP"
    end

    
    def push_notification
        puts "\n\n\n>>> Un nuevo producto en descuento, se encuentra disponible: #{self.title}"
    end


end
