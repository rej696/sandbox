import array
import math
import wave


FRAMERATE = 44100


def sound_wave(freq, num_secs):
    """
    Calculate the 8-bit unsigned integer PCM samples of a sin wave
    for a given freqency and number of seconds
    """
    for frame in range(round(num_secs * FRAMERATE)):
        time = frame / FRAMERATE  # current frame number / frame rate = time
        # A(t) = Asin(2 * PI * f * t + phase)
        amplitude = math.sin(2 * math.pi * freq * time)

        # add other octaves in the sine wave
        amplitude = (amplitude + math.sin(2 * math.pi * (freq / 2) * time)) / 2
        amplitude = (amplitude + math.sin(2 * math.pi * (freq / 4) * time)) / 2

        # scales and clamps the -1 -> 1 amplitude within signed 16 bits
        yield max(-32768, min(round(amplitude * 32768), 32767))


def generate_frames(wave):
    frames = array.array("h")
    for sample in wave:
        frames.append(sample)
    return frames.tobytes()


def write_sine(filename: str, freq: int):
    with wave.open(filename, mode="wb") as f:
        f.setnchannels(1)
        f.setsampwidth(2)
        f.setframerate(FRAMERATE)
        f.writeframes(generate_frames(sound_wave(freq, 2.5)))


if __name__ == "__main__":
    write_sine("output.wav", 440)
