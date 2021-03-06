class CreatePossuis < ActiveRecord::Migration
  def self.up
    create_table :possuis do |t|
      t.references :unidade
      t.string :tombo
      t.references :livro
      t.references :dicionario_enciclopedia
      t.references :jogo
      t.references :mapa
      t.references :midia
      t.references :periodico
      t.boolean :status
      t.integer :tipo

      t.timestamps
    end
  end

  def self.down
    drop_table :possuis
  end
end
