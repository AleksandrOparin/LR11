require 'json'

class String
  def palindrome?
    self == reverse
  end
end

class Integer
  def palindrome?
    to_s.palindrome?
  end
end

class PalindromesController < ApplicationController
  before_action :set_palindrome, only: %i[ show edit update destroy ]

  # Полный список запросов
  def index
    @palindromes = Palindrome.all
    respond_to do |format|
      format.html
      format.json do
        result_array = '[' + @palindromes.inject([]) { |acc, el| acc.append el.result }.join(",\n") + ']'
        render json: result_array
      end
    end
  end

  # Каждый запрос
  def show
  end

  # Для нового запроса
  def new
    @palindrome = Palindrome.new
  end

  # Для редактирования существующего запроса
  def edit
  end

  # Создаёт объект для нового запроса
  def create
    @palindrome = Palindrome.new(palindrome_params)

    @palindrome.result = output(palindrome_params[:number]).to_json if @palindrome.valid?

    id = Palindrome.search_id(palindrome_params[:number])
    if id.nil?
      respond_to do |format|
        if @palindrome.save
          format.html { redirect_to @palindrome, notice: "Palindrome was successfully created." }
          format.json { render :show, status: :created, location: @palindrome }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @palindrome.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to action: 'show', id: id
    end
  end

  # Обновляет данные существующего объекта запроса
  def update
    respond_to do |format|
      if @palindrome.update(palindrome_params)
        format.html { redirect_to @palindrome, notice: "Palindrome was successfully updated." }
        format.json { render :show, status: :ok, location: @palindrome }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @palindrome.errors, status: :unprocessable_entity }
      end
    end
  end

  # Удаляет существующий объект запроса
  def destroy
    @palindrome.destroy
    respond_to do |format|
      format.html { redirect_to palindromes_url, notice: "Palindrome was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_palindrome
      @palindrome = Palindrome.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def palindrome_params
      params.require(:palindrome).permit(:number)
    end

    def output(number)
      result = 0.upto(Integer(number)).select { |number| number.palindrome? && (number**2).palindrome? }

      { 
        values: result.map do |number|
          { result: number, square: number**2 }
        end, 
        length: result.length 
      }
    end
end
