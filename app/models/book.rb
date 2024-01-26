class Book < ApplicationRecord
  enum sales_status: {
    reservation: 0, # 予約受付
    now_on_sale: 1, # 発売中
    end_of_print: 2, # 販売終了
  }

  scope :costly, -> { where("price > ?", 3000) } # よく利用する検索条件に名前をつけてひとまとめにする
  scope :written_about, ->(theme) { where("name like ?", "%#{theme}%") } # (theme)：変数 "% %"：ワイルドカード
  # 以下は結果がnilの場合はScopeの検索条件を除外したクエリを発行し、ActiveRecord::Relationを返す
  # scope :find_price, ->(price) { find_by(price: price) }

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 } # 指定された値と等しいか、大きくならなければならない
  validate do |book| # 独自のバリデーションの追加の仕方
    if book.name.include?("exercise")
      book.errors[:name] << "I don't like exercise."
    end
  end

  before_validation do # コールバックを追加する
    self.name = self.name.gsub(/Cat/) do |matched| # gsub：文字列を別の文字列に置換する
      "lovely #{matched}"
    end
  end
  # 以下でも可能
  # before_validation :add_lovely_to_cat
  # def add_lovely_to_cat
  #   self.name = self.name.gsub(/Cat/) do |matched|
  #     "lovely #{matched}"
  #   end
  # end

  after_destroy do
    Rails.logger.info "Book is deleted: #{self.attributes}"
  end

  after_destroy :if => :high_price? do # :if, :unlessオブションで条件の分岐が可能
    Rails.logger.warn "Book with high price is deleted: #{self.attributes}"
    Rails.logger.warn "Please check!!"
  end

  def high_price?
    price >= 5000
  end
end
