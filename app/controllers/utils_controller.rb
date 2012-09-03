class UtilsController < ApplicationController

  def search
    q = params[:q]
    @q = params[:q]
    @t = params[:t]

    @partial = params[:p]

    if @t == "b" or @t.blank?
      @businesses = Business.where{(approved == true) & (name =~ "%#{q}%") | (address =~ "%#{q}") }
    elsif @t == "p"
      @products = Product.where{(name =~ "%#{q}%")}
    elsif @t == "c"
      @catalogs = Catalog.where{name =~ "%#{q}%"}
    end
  end

  def home

  end
end