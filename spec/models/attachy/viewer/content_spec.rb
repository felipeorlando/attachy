require 'rails_helper'

RSpec.describe Attachy::Viewer, '.content' do
  let!(:method)  { :avatar }
  let!(:object)  { create :user }
  let!(:file)    { create :file, attachable: object }
  let!(:options) { { button: { html: { key: :value } } } }

  before do
    nodes = double
    join  = double

    allow(subject).to receive(:nodes)  { nodes }
    allow(nodes).to receive(:join)     { join }
    allow(join).to receive(:html_safe) { :safe }

    allow(subject).to receive(:content_options) { { class: :attachy__content } }
  end

  subject { described_class.new method, object, options }

  describe 'default options' do
    it 'uses generic button options' do
      el = subject.content

      expect(el).to have_tag :ul, with: { class: 'attachy__content' }
    end

    it 'builds a content based on nodes' do
      el = subject.content

      expect(el).to have_tag :ul do
        with_text 'safe'
      end
    end
  end

  context 'when :html is present' do
    let!(:html) { { key: :value } }

    it 'merges with default' do
      el = subject.content(html: html)

      expect(el).to have_tag :ul, with: { class: 'attachy__content', key: 'value' }
    end
  end

  context 'when a block is given' do
    let!(:html) { { key: :value } }

    it 'yields the :html options' do
      subject.content(html: html) do |htm|
        expect(htm).to eq(key: :value, class: :attachy__content)
      end
    end
  end
end
