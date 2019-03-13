ActiveAdmin.register Tournament do

 actions :all, except: [:show, :edit, :update, :new, :create]

  index do
    selectable_column
    id_column
    column :remote_id
    column :name
    column :location do |t|
      "#{t.city}, #{t.region}"
    end
    column :venue_name
    column :address
    column :start_at
    column :end_at
    column :created_at
    column :updated_at
    column '' do |t|
      link_to("VOIR", "https://smash.gg/#{t.slug}", target: :blank)
    end
    actions
  end
end
