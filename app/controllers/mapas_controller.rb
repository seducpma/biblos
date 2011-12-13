class MapasController < ApplicationController

  before_filter :login_required
  before_filter :load_resources

  def index
  end

  def show
    @mapas = Mapa.find(params[:id])
  end

  def new
    @mapas = Mapa.new
  end

  def create
    @mapas = Mapa.new(params[:mapa])
    if @mapas.save
      flash[:notice] = "CADASTRADO COM SUCESSO."
      redirect_to @mapas
    else
      render :action => 'new'
    end
  end

def create_local
    @localizacao = Localizacao.new(params[:localizacao])
    @localizacao.add_unidade(current_user.unidade_id)
    if @localizacao.save
      @localizacoes = Localizacao.all
      @mapas = Mapa.new
      render :update do |page|
        page.replace_html 'local', :partial => "campos_local"
        page.replace_html 'aviso', :text => "NOVA LOCALIZAÇÃO CADASTRADA, CONTINUE O CADASTRO"
      end

    end
  end

  def edit
    @mapas = Mapa.find(params[:id])
  end

  def update
    @mapas = Mapas.find(params[:id])
    if @mapas.update_attributes(params[:mapa])
      flash[:notice] = "CADASTRADO COM SUCESSO."
      redirect_to @mapas
    else
      render :action => 'edit'
    end
  end

  def destroy
    @mapas = Mapa.find(params[:id])
    @mapas.destroy
    flash[:notice] = "EXCLUIDO COM SUCESSO."
    redirect_to mapas_url
  end

def consultaMap
t = params[:search]
 unless params[:search] != "Digite parte da busca"
   if params[:type_of].to_i == 3
     @mapas = Mapa.paginate :all, :page => params[:page], :per_page => 10,:order => 'titulo ASC'
          render :update do |page|
            page.replace_html 'mapas', :partial => "mapas"
          end

   end
 else
     if params[:type_of].to_i == 1
       @mapas = Mapa.paginate :all, :page => params[:page], :per_page => 10, :conditions => ["titulo like ? ", "%" + params[:search].to_s + "%"],:order => 'titulo ASC'
      else if params[:type_of].to_i == 2
         @mapas = Mapa.paginate :all, :page => params[:page], :per_page => 10, :conditions => ["subtitulo like ? ", "%" + params[:search].to_s + "%"],:order => 'subtitulo ASC'
      end
    end
    render :update do |page|
      page.replace_html 'mapas', :partial => "mapas"
    end

 end
end

    protected

  def load_resources
    @editoras = Editora.all(:order => 'nome ASC')
    @localizacoes = Localizacao.all
  end

end
