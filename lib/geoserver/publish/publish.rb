# frozen_string_literal: true

module Geoserver
  module Publish
    def delete_geotiff(workspace_name:, id:)
      CoverageStore.new.delete(workspace_name: workspace_name, coverage_store_name: id)
    end

    def delete_shapefile(workspace_name:, id:)
      DataStore.new.delete(workspace_name: workspace_name, data_store_name: id)
    end

    def create_coverage_store(workspace_name:, coverage_store_name:, url:)
      return if CoverageStore.new.find(workspace_name: workspace_name, coverage_store_name: coverage_store_name)
      CoverageStore.new.create(workspace_name: workspace_name, coverage_store_name: coverage_store_name, url: url)
    end

    def create_coverage(workspace_name:, coverage_store_name:, coverage_name:, title:)
      return if Coverage.new.find(workspace_name: workspace_name, coverage_store_name: coverage_store_name, coverage_name: coverage_name)
      Coverage.new.create(workspace_name: workspace_name, coverage_store_name: coverage_store_name, coverage_name: coverage_name, title: title)
    end

    def create_data_store(workspace_name:, data_store_name:, url:)
      return if DataStore.new.find(workspace_name: workspace_name, data_store_name: data_store_name)
      DataStore.new.create(workspace_name: workspace_name, data_store_name: data_store_name, url: url)
    end

    def create_feature_type(workspace_name:, data_store_name:, feature_type_name:, title:)
      return if FeatureType.new.find(workspace_name: workspace_name, data_store_name: data_store_name, feature_type_name: feature_type_name)
      FeatureType.new.create(workspace_name: workspace_name, data_store_name: data_store_name, feature_type_name: feature_type_name, title: title)
    end

    def create_workspace(workspace_name:)
      return if Workspace.new.find(workspace_name: workspace_name)
      Workspace.new.create(workspace_name: workspace_name)
    end

    def publish_geotiff(workspace_name:, file_path:, id:, title: nil)
      create_workspace(workspace_name: workspace_name)
      create_coverage_store(workspace_name: workspace_name, coverage_store_name: id, url: file_path)
      create_coverage(workspace_name: workspace_name, coverage_store_name: id, coverage_name: id, title: title)
    end

    def publish_shapefile(workspace_name:, file_path:, id:, title: nil)
      create_workspace(workspace_name: workspace_name)
      create_data_store(workspace_name: workspace_name, data_store_name: id, url: file_path)
      create_feature_type(workspace_name: workspace_name, data_store_name: id, feature_type_name: id, title: title)
    end

    module_function :create_coverage_store, :create_coverage, :create_data_store, :create_feature_type, :create_workspace, :publish_geotiff, :publish_shapefile
  end
end