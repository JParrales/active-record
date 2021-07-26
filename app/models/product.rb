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
    before_save :validate_product
    after_save :send_notification
    after_save :push_notification, if: :discount?

    def total
        self.price *3500
    end

    def discount?
        self.total < 50000
    end

    private 
    
    def validate_product
        puts "\n\n\n>>> Un nuevo producto será añadido a almacen"
    end
    
    def total
        self.price*3500
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
