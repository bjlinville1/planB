class Company < ActiveRecord::Base
  has_and_belongs_to_many :facilities
  has_many :company_users
  has_many :users, through: :company_users

  # Normally, the target class of an ActiveRecord association is inferred from the association’s name (a perfect example of “convention over configuration”). It is possible to override this default behavior, though, and specify a different target class. Doing so, it is even possible to have relationships between two objects of the same class.

  # This is how it is possible to set up a parent-child relationship. The model definition would look like:

  # class Person < ActiveRecord::Base
  #   belongs_to :parent, class: Person
  #   has_many :children, class: Person, foreign_key: :parent_id
  # end
  # It’s necessary to specify the foreign_key option for the has_many relationship because ActiveRecord will attempt to use :person_id by default. In the migration to create the table for this model, you would need to define, at minimum, a column for the name attribute as well as an integer column for parent_id.

  # Self-referential relationships can be extended in all the same ways as normal two-model relationships. This even includes has_many ... :through => ... style relationships. However, because we are circumventing Rails’ conventions, we will need to specify the source of the :through in the case of adding a grandchild relationship:

  # class Person < ActiveRecord::Base
  #   belongs_to :parent, class: Person
  #   has_many :children, class: Person, foreign_key: :parent_id
  #   has_many :grandchildren, class: Person, through: :children, source: :children
  # end
  # Consequently, since this is still just using the parent_id defined in the first case, no changes to the table in the database are required.
  
end
