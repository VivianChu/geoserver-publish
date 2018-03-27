# frozen_string_literal: true
RSpec.describe Geoserver::Publish do
  it "has a version number" do
    expect(Geoserver::Publish::VERSION).not_to be nil
  end

  describe "#publish_geotiff_layer" do
    let(:coverage) { instance_double(Geoserver::Publish::Coverage, create: true, find: nil) }
    let(:coveragestore) { instance_double(Geoserver::Publish::CoverageStore, create: true, find: nil) }
    let(:workspace) { instance_double(Geoserver::Publish::Workspace, create: true, find: nil) }

    before do
      allow(Geoserver::Publish::Workspace).to receive(:new).and_return(workspace)
      allow(Geoserver::Publish::Coverage).to receive(:new).and_return(coverage)
      allow(Geoserver::Publish::CoverageStore).to receive(:new).and_return(coveragestore)
    end

    it "creates a workspace, coveragestore, and coverage layer" do
      described_class.publish_geotiff(workspace_name: "public", file_path: "file:///raster.tif", id: "1234", title: "Title")
      expect(workspace).to have_received(:create)
      expect(coveragestore).to have_received(:create)
      expect(coverage).to have_received(:create)
    end
  end
end
