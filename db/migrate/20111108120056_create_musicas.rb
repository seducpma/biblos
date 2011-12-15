class CreateMusicas < ActiveRecord::Migration
  def self.up
    create_table :musicas do |t|
      t.string :nome
      t.timestamps
    end
  end

  def self.down
    drop_table :musicas
  end
end
