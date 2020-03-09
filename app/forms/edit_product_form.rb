class EditProductForm
    include ActiveModel::Model 

    attr_accessor :name, :price, :quantity

    validates :name, presence: true
    validates :price, presence: true, :numericality => {greater_than: 0}
    validates :quantity, presence: true, :numericality => {greater_than_or_equal_to: 0}

    def check
        
    end

end