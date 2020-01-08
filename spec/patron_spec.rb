require 'spec_helper.rb'

describe 'Patron' do
    describe '#==' do
        it 'compares for equality' do
            patron1 = Patron.new({name: 'Bob', contact: '1234567890'})
            patron2 = Patron.new({name: 'Bob', contact: '1234567890'})
            expect(patron1 == patron2).to eq(true)
        end
    end
    describe '#save' do
        it 'saves an Patron' do
            patron = Patron.new({name: 'Bob', contact: '1234567890'}).save
            expect(Patron.all).to include(patron)
        end
    end

    describe '#update' do
      it 'updates a patron record' do
        patron = Patron.new({name: 'Bob', contact: '1234567890'}).save
        patron.update({name: 'Robert', contact: '1234567777'})
        expect(patron.name).to eq('Robert')
      end
    end


    describe '#add_book' do
        it 'adds a book to a patron' do
            patron = Patron.new({name: 'Joe', contact: '1235551234'}).save
            book = Book.new({title: 'Best Book Ever', status: 't'}).save
            patron.add_book('Best Book Ever')
            expect(patron.books).to include(book)
        end
    end
#     describe '#delete' do
#         it 'deletes an Artist by id and all songs belong to Artist' do
#             artist = Artist.new({name: 'Cornbread'}).save
#             artist.delete
#             expect(Artist.all).not_to include(artist)
#         end
#     end
    describe '.all' do
        it 'returns a list of all Patrons' do
            expect(Patron.all).to eq([])
        end
    end
#     describe '.clear' do
#         it 'clears all Artists' do
#             Artist.clear
#             expect(Artist.all).to eq([])
#         end
#     end
#     describe '.find' do
#         it 'finds an Artist by id' do
#             artist = Artist.new({name: 'Cornbread'}).save
#             expect(Artist.find(artist.id)).to eq(artist)
#         end
#     end
end
