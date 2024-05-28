import { useGlobalState } from "../hooks";
import { useEffect } from "react";
function HomePage() {
	const { state, action } = useGlobalState();
	const { notification } = action;
	const { movies } = state;

	useEffect(() => {
		console.log(state);
	}, [state]);
	return (
		<div className="h-full mx-auto container py-4">
			<div className="flex flex-col justify-items-start place-items-center gap-4">
				{movies?.map((movie, index) => {
					return (
						<div
							key={index}
							className="border-2 border-blue-500 rounded-md w-fit min-w-96 flex flex-row"
						>
							<iframe
								width="560"
								height="315"
								src={movie.youtubeUrl}
								title="YouTube video player"
								allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
								referrerPolicy="strict-origin-when-cross-origin"
								allowfullscreen
							></iframe>

							<div className="flex flex-col px-4 py-4">
								<div className="flex flex-row gap-2">
									<div className="flex flex-col">
										<h1 className="text-xl text-red-500 font-medium">
											{movie?.title}
										</h1>
										<p>
											<a className="font-medium">Shared By: </a>
											<a className="font-light ">{movie?.uploader?.email}</a>
										</p>
										<div className="flex flex-row gap-4">
											<div>
												{movie?.metadata?.upvote} <button>👍</button>
											</div>
											<div>
												{movie?.metadata?.downvote} <button>👎</button>
											</div>
										</div>
									</div>
									<div className="text-6xl text-red-500">
										<button
											onClick={() =>
												notification.fire({
													title: "👍",
													text: "You have liked this movie",
													icon: "success",
												})
											}
										>
											👍
										</button>
										<button
											onClick={() =>
												notification.fire({
													title: "👎",
													text: "You have dislike this movie",
													icon: "success",
												})
											}
										>
											👎
										</button>
									</div>
								</div>
								<div>
									<a className="font-medium">Description: </a>
									<p className="font-light italic line-clamp-4">
										{movie?.description}
									</p>
								</div>
							</div>
						</div>
					);
				})}
			</div>
		</div>
	);
}

export default HomePage;
