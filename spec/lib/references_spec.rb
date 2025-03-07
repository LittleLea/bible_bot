require 'spec_helper'

describe BibleBot::References do
  let(:reference_string) { 'John 3:16-18, Mark 1:3-4' }
  let(:references) { BibleBot::Reference.parse(reference_string) }

  it { expect(references).to be_a(described_class) }

  describe '#contains_apocrypha?', :with_apocrypha do
    subject { references.contains_apocrypha? }

    context 'when references start with apocrypha' do
      let(:reference_string) { 'Tobit 1-3; Genesis 1-4' }
      it { is_expected.to eq(true) }
    end

    context 'when references end with apocrypha' do
      let(:reference_string) { 'Genesis 1-4; Tobit 1-3'}
      it { is_expected.to eq(true) }
    end

    context 'when references have apocrypha in the middle' do
      let(:reference_string) { 'Genesis 1-4; Tobit 1-2; Matthew 1-3'}
      it { is_expected.to eq(true) }
    end

    context 'when references contain no apocrypha' do
      let(:reference_string) { 'Genesis 1-4; Matthew 1-3'}
      it { is_expected.to eq(false) }
    end

    context 'when references are multi-book, excluding apocrypha' do
      let(:reference_string) { 'Genesis 1-4; Matthew 1 - John 2'}
      it { is_expected.to eq(false) }
    end

    context 'when references are multi-book, beginning with apocrypha' do
      let(:reference_string) { 'Genesis 1-4; Tobit 1 - Baruch 5'}
      it { is_expected.to eq(true) }
    end

    context 'when references are multi-book, ending with apocrypha' do
      let(:reference_string) { 'Genesis 1-4; Jude 1 - Baruch 5'}
      it { is_expected.to eq(true) }
    end
  end

  describe '#single_chapter?' do
    subject { references.single_chapter? }

    let(:reference_string) { 'Matthew 1' }

    it { is_expected.to eq(true) }

    context 'when verbose full chapter' do
      let(:reference_string) { 'Matthew 1:1-25' }
      it { is_expected.to eq(true) }
    end

    context 'when multiple chapters' do
      let(:reference_string) { 'Matthew 1-2' }
      it { is_expected.to eq(false) }
    end

    context 'when partial chapter' do
      let(:reference_string) { 'Matthew 1:3-5' }
      it { is_expected.to eq(true) }
    end

    context 'when multiple references' do
      let(:reference_string) { 'Matthew 1, John 3' }
      it { is_expected.to eq(false) }
    end
  end

  describe '#single_full_chapter?' do
    subject { references.single_full_chapter? }

    let(:reference_string) { 'Matthew 1' }

    it { is_expected.to eq(true) }

    context 'when verbose full chapter' do
      let(:reference_string) { 'Matthew 1:1-25' }
      it { is_expected.to eq(true) }
    end

    context 'when multiple chapters' do
      let(:reference_string) { 'Matthew 1-2' }
      it { is_expected.to eq(false) }
    end

    context 'when partial chapter' do
      let(:reference_string) { 'Matthew 1:3-5' }
      it { is_expected.to eq(false) }
    end

    context 'when multiple references' do
      let(:reference_string) { 'Matthew 1, John 3' }
      it { is_expected.to eq(false) }
    end
  end

  describe '#single_book?' do
    subject { references.single_book? }

    let(:reference_string) { 'Matthew 1' }

    it { is_expected.to eq(true) }

    context 'when empty' do
      let(:reference_string) { '' }
      it { is_expected.to eq(false) }
    end

    context 'when verbose full chapter' do
      let(:reference_string) { 'Matthew 1:1-25' }
      it { is_expected.to eq(true) }
    end

    context 'when multiple chapters' do
      let(:reference_string) { 'Matthew 1-2' }
      it { is_expected.to eq(true) }
    end

    context 'when multiple non-contiguous chapters' do
      let(:reference_string) { 'Matthew 1; Matthew 3' }
      it { is_expected.to eq(true) }
    end

    context 'when partial chapter' do
      let(:reference_string) { 'Matthew 1:3-5' }
      it { is_expected.to eq(true) }
    end

    context 'when multibook range' do
      let(:reference_string) { 'Matthew 1:3 - John 4:2' }
      it { is_expected.to eq(false) }
    end

    context 'when multiple references' do
      let(:reference_string) { 'Matthew 1, John 3' }
      it { is_expected.to eq(false) }
    end
  end

  describe '#chapter_string_ids' do
    subject { references.chapter_string_ids }

    let(:reference_string) { 'Matthew 1:3-10, Matthew 3-4, John 2:4-7' }

    it { is_expected.to eq(['matthew-001', 'matthew-003', 'matthew-004', 'john-002']) }
  end

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
