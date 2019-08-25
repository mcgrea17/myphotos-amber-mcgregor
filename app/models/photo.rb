class Photo < ApplicationRecord
    mount_uploader :picture, PictureUploader
    validates :picture, presence: true
    belongs_to :location
    belongs_to :user
    

    def self.search(term, current_page)
        if term
         page(current_page).where('name LIKE ?', "%#{term}%").order('id DESC')
        else
         page(current_page).order('id DESC') 
        end
      end
    
      def self.search(term, page)
        if term
         where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 12).order('id DESC')
        else
         paginate(page: page, per_page: 12).order('id DESC') 
        end
      end
end
