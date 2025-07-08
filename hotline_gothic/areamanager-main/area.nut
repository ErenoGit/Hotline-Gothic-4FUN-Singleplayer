class Area
{
	points = null

	minY = null
	maxY = null

	bbox = null

	world = null

	metadata = null

	constructor(arg)
	{
		points = arg.points
		world = arg.world.toupper()

		if ("minY" in arg)
			minY = arg.minY

		if ("maxY" in arg)
			maxY = arg.maxY

		metadata = "metadata" in arg ? arg.metadata : {}

		local pointsCount = points.len()

		if (pointsCount < 1)
			return

		bbox = {minX = points[0].x, maxX = points[0].x, minZ = points[0].z, maxZ = points[0].z}

		for (local i = 1; i < pointsCount; ++i)
		{
			local point = points[i]

			if (bbox.minX > point.x)
				bbox.minX = point.x

			if (bbox.maxX < point.x)
				bbox.maxX = point.x

			if (bbox.minZ > point.z)
				bbox.minZ = point.z

			if (bbox.maxZ < point.z)
				bbox.maxZ = point.z
		}
	}

	function isIn(x, y, z, world)
	{
		if (world != this.world)
			return false

		if (minY != null && maxY != null
			&& y > maxY || y < minY)
			return false

		if (bbox != null
			&& (x < bbox.minX || x > bbox.maxX || z < bbox.minZ || z > bbox.maxZ))
			return false

		local pointsCount = points.len()
		local j = pointsCount - 1

		local isIn = false

		for (local i = 0; i < pointsCount; j = i++)
		{
			if ( (points[i].z > z) != (points[j].z > z)
			&& (x < (points[j].x - points[i].x) * (z - points[i].z) / (points[j].z - points[i].z) + points[i].x) )
			{
				isIn = !isIn
			}
		}

		return isIn
	}
}
