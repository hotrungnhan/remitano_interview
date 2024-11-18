# frozen_string_literal: true

class Query < Hash
  def where(**options)
    merge!(options)
  end
end

class BookFilter < Filters::ApplicationFilter
  keys :author, :genre
  def by_author
    return if params[:author].blank?

    query.where(author: params[:author])
  end

  def by_genre
    return if params[:genre].blank?

    query.where(genre: params[:genre])
  end
end

RSpec.describe Filters::ApplicationFilter do
  let(:params) { { author: 'John Doe', genre: 'Fiction', not_exist: 'abc' } }
  let(:query) { Query.new }

  before do
    described_class.instance_variable_set(:@keys, [])
    described_class.instance_variable_set(:@default_query, nil)
  end

  describe '#initialize' do
    it 'sets the params and query' do
      filter = described_class.new(params, query)
      expect(filter.params).to eq(params)
      expect(filter.query).to eq(query)
    end

    it 'raises an error if query is not defined' do
      expect { described_class.new(params) }.to raise_error # rubocop:disable RSpec/UnspecifiedException
    end
  end

  describe 'Test inherits class' do
    it 'calls the filter methods and returns the query' do
      expect(BookFilter.superclass).to eq(described_class)

      filter = BookFilter.new(params, query)
      expect(filter.exec).to eq(query)
      expect(query).to eq(author: 'John Doe', genre: 'Fiction')
    end
  end

  describe 'Test class variable' do
    describe '#keys' do
      it 'adds keys to the filter' do
        described_class.keys(:status, :category)
        expect(described_class.instance_variable_get(:@keys)).to eq(%i[status category])
      end
    end

    describe '#default_query' do
      it 'sets the default query' do
        described_class.default_query(query)
        expect(described_class.instance_variable_get(:@default_query)).to eq(query)
      end
    end
  end
end
