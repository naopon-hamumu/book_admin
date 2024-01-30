class BooksController < ApplicationController
  protect_from_forgery except: [:destroy] # CSRF対策をOFFにする
  # protect_from_forgery except: :update
  before_action :set_book, only: [:show, :destroy]
  around_action :action_logger, only: [:destroy]

  def show
    respond_to do |format| # 2種類のフォーマットでビューのレンダリングを行う
      format.html do |html|
        html.mobile { redirect_to profile_path }
      end
      format.json { render json: @book }
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def action_logger
    logger.info "around-before"
    yield # before相当の処理を実行した後に、アクション側に戻すため
    logger.info "around-after"
  end
end
