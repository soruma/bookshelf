# frozen_string_literal: true

json.array! @bookcases, partial: 'users/bookcases/bookcase', as: :bookcase
