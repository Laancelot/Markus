require File.dirname(__FILE__) + '/../test_helper'

class AnnotationTest < ActiveSupport::TestCase
  
# Test that Annotation without pos_start are not valid
  def test_no_pos_start
    no_pos_start = create_no_attr(:pos_start);
    assert !no_pos_start.valid?
  end
  
  # Test that Annotation without pos_end are not valid
  def test_no_pos_end
    no_pos_end = create_no_attr(:pos_end);
    assert !no_pos_end.valid?
  end
  
  # Test that Annotation without line_start are not valid
  def test_no_line_start
    no_line_start = create_no_attr(:line_start);
    assert !no_line_start.valid?
  end
  
  # Test that Annotation without line_end are not valid
  def test_no_line_end
    no_line_end = create_no_attr(:line_end);
    assert !no_line_end.valid?
  end
  
  #Description Id must be an integer greater or equal to 0
  def test_annotation_label_id_range
    annotation_label_id_range = create_no_attr(nil)

    bad = %w{ 'string', -0.1, -1, 0}

    bad.each do |id|

        annotation_label_id_range.annotation_label_id = id
        assert !annotation_label_id_range.valid?

    end    

  end

  #Description Id must be an integer greater or equal to 0
  def test_submissionfile_id_range
    submissionfile_id_range = create_no_attr(nil)

    bad = %w{ 'string', -0.1, -1, 0}

    bad.each do |id|

        submissionfile_id_range.submission_file_id = id
        assert !submissionfile_id_range.valid?

    end

  end


  #Test that Annotation assigned to non-existant Description is not valid
  def test_annotation_label_id_dne
    annotation_label_id_dne = create_no_attr(nil)
    annotation_label_id_dne.annotation_label = AnnotationLabel.new
    assert !annotation_label_id_dne.save
  end
  
  #Test that Annotation assigned to non-existant File is not valid

  def test_submission_file_id_dne
    submission_file_id_dne = create_no_attr(nil)
    submission_file_id_dne.submission_file = SubmissionFile.new
    assert !submission_file_id_dne.save
  end
  
  
  # Helper method for test_validate_presence_of to create a annotation without 
  # the specified attribute. if attr == nil then all attributes are included
  def create_no_attr(attr)
    new_annotation = { 
      :pos_start => 1,
      :pos_end => 10, 
      :line_start => 1, 
      :line_end => 10,
      :annotation_label_id => 1,
      :submission_file_id => 1
    }
    
   
    new_annotation.delete(attr) if attr
    Annotation.new(new_annotation)
  end
end