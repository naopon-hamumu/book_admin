class FooController < ApplicationController
  def index
    raise ArgumentError, 'something error' # 例外とステータスコードを紐付ける
  end
end
