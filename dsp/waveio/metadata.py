from dataclasses import dataclass

from .encoding import PCMEncoding


@dataclass(frozen=True)
class WAVMetadata:
    encoding: PCMEncoding
    framerate: float
    num_channels: int
    num_frames: int | None = None

    @property
    def num_seconds(self):
        if self.num_frames is None:
            raise ValueError("indeterminate stream of audio frames")
        return self.num_frames / self.framerate
