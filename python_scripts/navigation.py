from google.colab import files
# Upload your GPX file
uploaded = files.upload()
# Confirm the file is uploaded
for filename in uploaded.keys():
    print(f'File uploaded: {filename}')
!pip install gpxpy

import gpxpy
# Read and parse the uploaded GPX file
with open('jais3.gpx', 'r') as gpx_file:
    gpx = gpxpy.parse(gpx_file)
# Extract waypoints
waypoints = gpx.waypoints
print("Waypoints:")
for waypoint in waypoints:
    print(f"Name: {waypoint.name}, Latitude: {waypoint.latitude}, Longitude: {waypoint.longitude}")
# Extract routes
routes = gpx.routes
print("\nRoutes:")
for route in routes:
    for point in route.points:
        print(f"Route Point: Latitude: {point.latitude}, Longitude: {point.longitude}")

import folium
import gpxpy
import heapq
from geopy.distance import geodesic
# Maximum distance allowed for the next point in meters
MAX_DISTANCE_THRESHOLD = 4  # meters
# Function to find the closest point to a given location
def find_closest_point(lat, lon, points):
    closest_point = None
    min_distance = float('inf')
    for point in points:
        distance = geodesic((lat, lon), (point.latitude, point.longitude)).meters
        if distance < min_distance:
            closest_point = point
            min_distance = distance
    return closest_point
# A* Pathfinding Algorithm with backtracking at dead ends
def a_star_with_backtracking(start_point, end_point, route_points):
    open_list = []
    heapq.heappush(open_list, (0, start_point))
    came_from = {}
    g_score = {point: float('inf') for point in route_points}
    g_score[start_point] = 0
    f_score = {point: float('inf') for point in route_points}
    f_score[start_point] = geodesic((start_point.latitude, start_point.longitude), (end_point.latitude, end_point.longitude)).meters
    while open_list:
        current = heapq.heappop(open_list)[1]
        if current == end_point:
            # Reconstruct the path
            path = []
            while current in came_from:
                path.append(current)
                current = came_from[current]
            path.append(start_point)
            return path[::-1]  # Reverse the path to start from the beginning
        for neighbor in route_points:
            if neighbor == current:
                continue
            
            distance_to_neighbor = geodesic((current.latitude, current.longitude), (neighbor.latitude, neighbor.longitude)).meters
            if distance_to_neighbor <= MAX_DISTANCE_THRESHOLD:
                tentative_g_score = g_score[current] + distance_to_neighbor
                if tentative_g_score < g_score[neighbor]:
                    came_from[neighbor] = current
                    g_score[neighbor] = tentative_g_score
                    f_score[neighbor] = g_score[neighbor] + geodesic((neighbor.latitude, neighbor.longitude), (end_point.latitude, end_point.longitude)).meters
                    heapq.heappush(open_list, (f_score[neighbor], neighbor))
    return []
# Extract waypoints (you'll load this from your GPX file as before)
waypoints = gpx.waypoints  # Already loaded waypoints from GPX file
routes = gpx.routes  # Already loaded routes from GPX file
all_route_points = [point for route in routes for point in route.points]  # Flatten route points
# Get the current location and destination waypoints
def get_valid_waypoint(waypoint_name):
    while True:
        waypoint = next((wp for wp in waypoints if wp.name.lower() == waypoint_name.lower()), None)
        if waypoint:
            return waypoint
        else:
            print(f"Invalid waypoint name: {waypoint_name}")
            waypoint_name = input("Please enter a valid waypoint name: ")
# User inputs
current_waypoint_name = input("\nEnter the name of your current location waypoint: ")
current_waypoint = get_valid_waypoint(current_waypoint_name)
destination_waypoint_name = input("\nEnter the name of the destination waypoint: ")
destination_waypoint = get_valid_waypoint(destination_waypoint_name)
# Find the closest node to the current location and destination
closest_point_to_current_location = find_closest_point(current_waypoint.latitude, current_waypoint.longitude, all_route_points)
closest_point_to_destination = find_closest_point(destination_waypoint.latitude, destination_waypoint.longitude, all_route_points)
# Run A* Pathfinding with backtracking to get the shortest connected path
shortest_path = a_star_with_backtracking(closest_point_to_current_location, closest_point_to_destination, all_route_points)
# Create a map centered at the current location
mymap = folium.Map(location=[current_waypoint.latitude, current_waypoint.longitude], zoom_start=17)
# Add marker for current location with label 'Current Location'
folium.Marker(
    location=[current_waypoint.latitude, current_waypoint.longitude],
    popup="Current Location",
    icon=folium.Icon(color="green", icon="info-sign"),
    tooltip="Current Location"
).add_to(mymap)
# Add marker for destination with label 'Destination'
folium.Marker(
    location=[destination_waypoint.latitude, destination_waypoint.longitude],
    popup=f"Destination: {destination_waypoint.name}",
    icon=folium.Icon(color="red", icon="info-sign"),
    tooltip="Destination"
).add_to(mymap)
# Plot the shortest path on the map
if shortest_path:
    path_coordinates = [(point.latitude, point.longitude) for point in shortest_path]
    folium.PolyLine(locations=path_coordinates, color="blue", weight=5, popup="Path").add_to(mymap)
else:
    print("No valid path found within the distance threshold.")
# Display the map
mymap
