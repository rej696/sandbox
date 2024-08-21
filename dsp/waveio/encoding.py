from enum import IntEnum

import numpy as np


class PCMEncoding(IntEnum):
    UINT8 = 1
    INT16 = 2
    INT24 = 3
    INT32 = 4

    @property
    def max(self):
        return 255 if self == self.UINT8 else -self.min - 1

    @property
    def min(self):
        return 0 if self == self.UINT8 else -(2 ** (self.num_bits - 1))

    @property
    def num_bits(self):
        return 8 * self

    def decode(self, frames):
        match self:
            case PCMEncoding.UINT8:
                return np.frombuffer(frames, "u1") / self.max * 2 - 1
            case PCMEncoding.INT16:
                return np.frombuffer(frames, "<i2") / -self.min
            case PCMEncoding.INT24:
                # -1 means the number of rows is inferred
                triplets = np.frombuffer(frames, "u1").reshape(-1, 3)
                # pad 0's into a 4th column
                padded = np.pad(triplets, ((0, 0), (0, 1)), mode="constant")
                # flatten and interpret as INT32's
                samples = padded.flatten().view("<i4")
                # sort out the sign bit
                samples[samples > self.max] += 2 * self.min
                return samples / -self.min

            case PCMEncoding.INT32:
                return np.frombuffer(frames, "<i4") / -self.min
            case _:
                raise TypeError("unsupported encoding")

    def _clamp(self, samples):
        return np.clip(samples, self.min, self.max)

    def encode(self, amplitudes):
        match self:
            case PCMEncoding.UINT8:
                samples = np.round((amplitudes + 1) / 2 * self.max)
                return self._clamp(samples).astype("u1").tobytes()
            case PCMEncoding.INT16:
                samples = np.round(-self.min * amplitudes)
                return self._clamp(samples).astype("<i2").tobytes()
            case PCMEncoding.INT24:
                samples = np.round(-self.min * amplitudes)
                return (
                    self._clamp(samples)
                    .astype("<i4")
                    .view("u1")
                    .reshape(-1, 4)[:, :3]
                    .flatten()
                    .tobytes()
                )

            case PCMEncoding.INT32:
                samples = np.round(-self.min * amplitudes)
                return self._clamp(samples).astype("<i4").tobytes()
            case _:
                raise TypeError("unsupported encoding")
