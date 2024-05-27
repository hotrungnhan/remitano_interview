import { useGlobalState } from "../hooks";
import { useEffect } from "react";
function HomePage() {
	const { state } = useGlobalState();

	const { movies } = state;

	useEffect(() => {
		console.log(state);
	}, [state]);
	return (
		<div>
			Home
			{movies?.map((movie, index) => {
				return (
					<div key={index}>
						<h1>{movie.title}</h1>
						<p>{movie.description}</p>
					</div>
				);
			})}
		</div>
	);
}

export default HomePage;
