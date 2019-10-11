require 'rails_helper'

describe DynamicForms::SubmissionExporter do
  let!(:submissions) { create_list(:submission, 5, created_at: '2019-10-08 19:39:06 UTC') }
  let!(:with_different_field) { 
    create_list(
      :submission, 
      5, 
      fields: { age: '12', phone: '1231432', gender: 'F' }, 
      created_at: '2019-10-08 19:39:06 UTC'
    ) 
  }

  let(:all_submissions) {  DynamicForms::Submission.all }

  context 'when submissions are not sent correclty' do
    subject { DynamicForms::SubmissionExporter.for(nil, 'csv') }
    it 'returns an ArgumentError' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  context 'when the format type is not sent correctly' do
    context 'when the format type is not string' do
      subject { DynamicForms::SubmissionExporter.for(all_submissions, nil) }

      it 'returns a TypeError' do
        expect { subject }.to raise_error(TypeError)
      end
    end

    context 'when the format type is not available' do
      subject { DynamicForms::SubmissionExporter.for(all_submissions, 'pdf') }

      it 'returns a ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  context '#to_csv' do
    subject { DynamicForms::SubmissionExporter.for(all_submissions, 'csv') }
    let!(:rows) { subject.split("\n") }

    it 'returns a csv content with 11 lines' do
      expect(rows.size).to eq(11)
    end

    it 'includes the header' do
      expect(rows.first).to eq('Created at,Gender,_subject,Phone,Age,Email,Name')
    end

    it 'includes data with fields correctly' do
      expect(rows.slice(2)).to eq("\"October 10, 2019, 19:39\",,Test email,,,custom@mail.com,John")
      expect(rows.slice(6)).to eq("\"October 10, 2019, 19:39\",F,,1231432,12")
    end
  end

  context '#to_xlsx' do
    subject { DynamicForms::SubmissionExporter.for(all_submissions, 'xlsx') }
    let!(:xlsx) {  
      temp = Tempfile.new(['submissions', '.xlsx'])
      temp.write(subject)
      temp.close
      Roo::Excelx.new(temp.path)
    }

    it 'includes the header and data of submissions' do
      expect(xlsx.row(1)).to eq(["Created at", "Gender", "_subject", "Phone", "Age", "Email", "Name"])
      expect(xlsx.row(2)).to eq(["October 10, 2019, 19:39", nil, "Test email", nil, nil, "custom@mail.com", "John"])
      expect(xlsx.row(8)).to eq(["October 10, 2019, 19:39", "F", nil, 1231432.0, 12.0, nil, nil])
    end
  end
end
