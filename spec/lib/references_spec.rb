require 'spec_helper'

describe BibleBot::References do
  let(:reference_string) { 'John 3:16-18, Mark 1:3-4' }
  let(:references) { BibleBot::Reference.parse(reference_string) }

  it { expect(references).to be_a(described_class) }

  describe '#ids' do
    subject { references.ids }
    let(:expected_ids) { [43003016, 43003017, 43003018, 41001003, 41001004] }
    it { is_expected.to eq(expected_ids) }

    context 'when reference string is nil' do
      let(:reference_string) { nil }
      it { is_expected.to eq([]) }
    end

    context 'when reference string is blank' do
      let(:reference_string) { '    ' }
      it { is_expected.to eq([]) }
    end
  end

  describe '#string_ids' do
    subject { references.string_ids }
    let(:expected_ids) do
      ['john-003-016', 'john-003-017', 'john-003-018', 'mark-001-003', 'mark-001-004']
    end

    it { is_expected.to eq(expected_ids) }

    context 'when reference string is nil' do
      let(:reference_string) { nil }
      it { is_expected.to eq([]) }
    end

    context 'when reference string is blank' do
      let(:reference_string) { '    ' }
      it { is_expected.to eq([]) }
    end
  end
end
